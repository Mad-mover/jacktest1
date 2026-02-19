-- =====================================================
-- INVENTORY LEDGER MIGRATION
-- Implements audit-trail based inventory management
-- =====================================================

-- 1. CREATE MOVEMENT TYPE ENUM
-- =====================================================
CREATE TYPE movement_type AS ENUM (
  'purchase_in',
  'sale_out',
  'transfer_out',
  'transfer_in',
  'customer_return',
  'supplier_return',
  'stock_adjustment_in',
  'stock_adjustment_out',
  'damaged_out',
  'expired_out'
);

-- 2. CREATE INVENTORY_MOVEMENTS TABLE (APPEND-ONLY LEDGER)
-- =====================================================
CREATE TABLE inventory_movements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
  branch_id UUID NOT NULL REFERENCES branches(id) ON DELETE RESTRICT,
  movement_type movement_type NOT NULL,
  quantity_change INTEGER NOT NULL,
  reference_id UUID,
  reference_type TEXT,
  notes TEXT,
  created_by UUID, -- Will reference auth.users() if you have Supabase Auth enabled
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  reversed_movement_id UUID REFERENCES inventory_movements(id)
);

-- 3. ADD CHECK CONSTRAINTS (ENFORCE QUANTITY SIGNS)
-- =====================================================

-- Purchase must be positive
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_purchase_positive 
  CHECK (movement_type != 'purchase_in' OR quantity_change > 0);

-- Sales must be negative
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_sale_negative
  CHECK (movement_type != 'sale_out' OR quantity_change < 0);

-- Transfer out must be negative
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_transfer_out_negative
  CHECK (movement_type != 'transfer_out' OR quantity_change < 0);

-- Transfer in must be positive
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_transfer_in_positive
  CHECK (movement_type != 'transfer_in' OR quantity_change > 0);

-- Customer return must be positive (returned to inventory)
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_customer_return_positive
  CHECK (movement_type != 'customer_return' OR quantity_change > 0);

-- Supplier return must be negative (returned from inventory)
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_supplier_return_negative
  CHECK (movement_type != 'supplier_return' OR quantity_change < 0);

-- Damaged must be negative (removed from inventory)
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_damaged_negative
  CHECK (movement_type != 'damaged_out' OR quantity_change < 0);

-- Expired must be negative (removed from inventory)
ALTER TABLE inventory_movements 
  ADD CONSTRAINT check_expired_negative
  CHECK (movement_type != 'expired_out' OR quantity_change < 0);

-- Stock adjustment can be positive or negative (no constraint)

-- 4. CREATE INDEXES (FOR QUERY PERFORMANCE)
-- =====================================================
CREATE INDEX idx_movements_product ON inventory_movements(product_id);
CREATE INDEX idx_movements_branch ON inventory_movements(branch_id);
CREATE INDEX idx_movements_reference ON inventory_movements(reference_id, reference_type);
CREATE INDEX idx_movements_created_at ON inventory_movements(created_at DESC);
CREATE INDEX idx_movements_type ON inventory_movements(movement_type);

-- 5. CREATE CURRENT_STOCK_PER_BRANCH VIEW
-- =====================================================
CREATE OR REPLACE VIEW current_stock_per_branch AS
SELECT 
  product_id,
  branch_id,
  SUM(quantity_change) as quantity,
  MAX(created_at) as last_updated
FROM inventory_movements
GROUP BY product_id, branch_id
HAVING SUM(quantity_change) != 0; -- Only show branches with non-zero stock

-- 6. MIGRATE EXISTING DATA
-- =====================================================
-- Convert existing product_stock records to initial movements
-- This preserves current stock levels as adjustment entries
INSERT INTO inventory_movements (
  product_id, 
  branch_id, 
  movement_type, 
  quantity_change, 
  reference_type, 
  notes, 
  created_at
)
SELECT 
  product_id,
  branch_id,
  'stock_adjustment_in'::movement_type,
  quantity,
  'initial_migration',
  'Migrated from product_stock table during ledger implementation on 2026-02-12',
  COALESCE(last_updated, NOW())
FROM product_stock
WHERE quantity > 0;

-- Handle zero/negative quantities as adjustments out (if any exist)
INSERT INTO inventory_movements (
  product_id, 
  branch_id, 
  movement_type, 
  quantity_change, 
  reference_type, 
  notes, 
  created_at
)
SELECT 
  product_id,
  branch_id,
  'stock_adjustment_out'::movement_type,
  quantity, -- Will be negative
  'initial_migration',
  'Migrated from product_stock table during ledger implementation on 2026-02-12',
  COALESCE(last_updated, NOW())
FROM product_stock
WHERE quantity < 0;

-- 7. ENABLE ROW LEVEL SECURITY
-- =====================================================
ALTER TABLE inventory_movements ENABLE ROW LEVEL SECURITY;

-- Allow read for authenticated users
CREATE POLICY "Allow read movements for authenticated users"
  ON inventory_movements FOR SELECT
  USING (true); -- Change to auth.uid() IS NOT NULL if you have auth enabled

-- Allow insert for authenticated users
CREATE POLICY "Allow insert movements for authenticated users"
  ON inventory_movements FOR INSERT
  WITH CHECK (true); -- Change to auth.uid() IS NOT NULL if you have auth enabled

-- Prevent updates (append-only ledger)
CREATE POLICY "Prevent updates on movements"
  ON inventory_movements FOR UPDATE
  USING (false);

-- Prevent deletes (append-only ledger)
CREATE POLICY "Prevent deletes on movements"
  ON inventory_movements FOR DELETE
  USING (false);

-- 8. CREATE HELPER FUNCTION FOR STOCK VALIDATION
-- =====================================================
-- Function to get current stock for a product at a branch
CREATE OR REPLACE FUNCTION get_current_stock(p_product_id UUID, p_branch_id UUID)
RETURNS INTEGER AS $$
  SELECT COALESCE(SUM(quantity_change), 0)
  FROM inventory_movements
  WHERE product_id = p_product_id 
    AND branch_id = p_branch_id;
$$ LANGUAGE SQL STABLE;

-- 9. CREATE TRANSFER FUNCTION (ATOMIC OPERATION)
-- =====================================================
-- Function to create both transfer movements atomically
CREATE OR REPLACE FUNCTION create_transfer(
  p_product_id UUID,
  p_from_branch_id UUID,
  p_to_branch_id UUID,
  p_quantity INTEGER,
  p_notes TEXT DEFAULT NULL,
  p_created_by UUID DEFAULT NULL
)
RETURNS TABLE (
  transfer_out_id UUID,
  transfer_in_id UUID,
  reference_id UUID
) AS $$
DECLARE
  v_reference_id UUID;
  v_transfer_out_id UUID;
  v_transfer_in_id UUID;
BEGIN
  -- Validate stock availability
  IF get_current_stock(p_product_id, p_from_branch_id) < p_quantity THEN
    RAISE EXCEPTION 'Insufficient stock at source branch. Available: %, Required: %', 
      get_current_stock(p_product_id, p_from_branch_id), p_quantity;
  END IF;

  -- Generate shared reference ID
  v_reference_id := gen_random_uuid();

  -- Create transfer out movement
  INSERT INTO inventory_movements (
    product_id, 
    branch_id, 
    movement_type, 
    quantity_change, 
    reference_id, 
    reference_type, 
    notes, 
    created_by
  ) VALUES (
    p_product_id,
    p_from_branch_id,
    'transfer_out',
    -p_quantity,
    v_reference_id,
    'transfer',
    p_notes,
    p_created_by
  ) RETURNING id INTO v_transfer_out_id;

  -- Create transfer in movement
  INSERT INTO inventory_movements (
    product_id, 
    branch_id, 
    movement_type, 
    quantity_change, 
    reference_id, 
    reference_type, 
    notes, 
    created_by
  ) VALUES (
    p_product_id,
    p_to_branch_id,
    'transfer_in',
    p_quantity,
    v_reference_id,
    'transfer',
    p_notes,
    p_created_by
  ) RETURNING id INTO v_transfer_in_id;

  -- Return both IDs and the shared reference
  RETURN QUERY SELECT v_transfer_out_id, v_transfer_in_id, v_reference_id;
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- MIGRATION COMPLETE
-- =====================================================
-- Next steps:
-- 1. Verify the migration in Supabase SQL Editor
-- 2. Check that existing stock data appears in inventory_movements
-- 3. Test the current_stock_per_branch view
-- 4. Update Flutter code to use new ledger system
-- =====================================================
