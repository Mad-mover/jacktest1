-- =====================================================
-- PURCHASES & SUPPLIERS MANAGEMENT
-- Tracks purchases from suppliers with payment history
-- =====================================================

-- 1. CREATE SUPPLIERS TABLE
-- =====================================================
CREATE TABLE suppliers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  contact_person TEXT,
  phone TEXT,
  email TEXT,
  address TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. CREATE PURCHASES TABLE
-- =====================================================
CREATE TABLE purchases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  supplier_id UUID NOT NULL REFERENCES suppliers(id),
  branch_id UUID NOT NULL REFERENCES branches(id),
  purchase_date DATE NOT NULL,
  invoice_number TEXT,
  total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
  paid_amount DECIMAL(10,2) DEFAULT 0 CHECK (paid_amount >= 0),
  payment_status TEXT DEFAULT 'unpaid' CHECK (payment_status IN ('unpaid', 'partial', 'paid')),
  notes TEXT,
  created_by UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. CREATE PURCHASE ITEMS TABLE
-- =====================================================
CREATE TABLE purchase_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_id UUID NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES products(id),
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. CREATE PURCHASE PAYMENTS TABLE
-- =====================================================
CREATE TABLE purchase_payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_id UUID NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
  payment_date DATE NOT NULL,
  payment_method TEXT, -- cash, bank_transfer, check, etc.
  reference_number TEXT,
  notes TEXT,
  created_by UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. CREATE INDEXES
-- =====================================================
CREATE INDEX idx_purchases_supplier ON purchases(supplier_id);
CREATE INDEX idx_purchases_branch ON purchases(branch_id);
CREATE INDEX idx_purchases_date ON purchases(purchase_date DESC);
CREATE INDEX idx_purchases_status ON purchases(payment_status);
CREATE INDEX idx_purchase_items_purchase ON purchase_items(purchase_id);
CREATE INDEX idx_purchase_items_product ON purchase_items(product_id);
CREATE INDEX idx_purchase_payments_purchase ON purchase_payments(purchase_id);

-- 6. CREATE VIEWS
-- =====================================================

-- View for purchase summary with supplier info
CREATE OR REPLACE VIEW purchase_summary AS
SELECT 
  p.id,
  p.purchase_date,
  p.invoice_number,
  p.total_amount,
  p.paid_amount,
  p.payment_status,
  p.branch_id,
  s.name as supplier_name,
  s.id as supplier_id,
  (p.total_amount - p.paid_amount) as balance_due,
  p.created_at
FROM purchases p
JOIN suppliers s ON p.supplier_id = s.id
ORDER BY p.purchase_date DESC;

-- View for purchase items with product details
CREATE OR REPLACE VIEW purchase_items_detail AS
SELECT 
  pi.id,
  pi.purchase_id,
  pi.quantity,
  pi.unit_price,
  pi.total_price,
  p.name as product_name,
  p.id as product_id,
  p.category
FROM purchase_items pi
JOIN products p ON pi.product_id = p.id;

-- 7. CREATE TRIGGERS
-- =====================================================

-- Update purchase payment status when payments are added
CREATE OR REPLACE FUNCTION update_purchase_payment_status()
RETURNS TRIGGER AS $$
DECLARE
  total_paid DECIMAL(10,2);
  purchase_total DECIMAL(10,2);
BEGIN
  -- Calculate total paid for this purchase
  SELECT COALESCE(SUM(amount), 0) INTO total_paid
  FROM purchase_payments
  WHERE purchase_id = NEW.purchase_id;
  
  -- Get purchase total
  SELECT total_amount INTO purchase_total
  FROM purchases
  WHERE id = NEW.purchase_id;
  
  -- Update purchase paid_amount and status
  UPDATE purchases
  SET 
    paid_amount = total_paid,
    payment_status = CASE
      WHEN total_paid = 0 THEN 'unpaid'
      WHEN total_paid >= purchase_total THEN 'paid'
      ELSE 'partial'
    END,
    updated_at = NOW()
  WHERE id = NEW.purchase_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_payment_status
AFTER INSERT ON purchase_payments
FOR EACH ROW
EXECUTE FUNCTION update_purchase_payment_status();

-- 8. CREATE FUNCTIONS
-- =====================================================

-- Function to get outstanding balance for a supplier
CREATE OR REPLACE FUNCTION get_supplier_balance(p_supplier_id UUID)
RETURNS DECIMAL(10,2) AS $$
  SELECT COALESCE(SUM(total_amount - paid_amount), 0)
  FROM purchases
  WHERE supplier_id = p_supplier_id
    AND payment_status != 'paid';
$$ LANGUAGE SQL STABLE;

-- =====================================================
-- MIGRATION COMPLETE
-- =====================================================
-- Next steps:
-- 1. Create Flutter models for Supplier, Purchase, PurchaseItem, PurchasePayment
-- 2. Create repositories
-- 3. Create UI pages
-- 4. Integrate with InventoryService for automatic stock updates
-- =====================================================
