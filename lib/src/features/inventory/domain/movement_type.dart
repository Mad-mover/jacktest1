/// Movement types for inventory tracking
/// Each type defines the direction of stock movement and business context
enum MovementType {
  /// Stock coming in from purchase orders
  purchaseIn('purchase_in', 'Purchase In', true),

  /// Stock going out due to sales
  saleOut('sale_out', 'Sale Out', false),

  /// Stock leaving source branch in a transfer
  transferOut('transfer_out', 'Transfer Out', false),

  /// Stock arriving at destination branch in a transfer
  transferIn('transfer_in', 'Transfer In', true),

  /// Customer returned items back to inventory
  customerReturn('customer_return', 'Customer Return', true),

  /// Items returned to supplier (reduced from inventory)
  supplierReturn('supplier_return', 'Supplier Return', false),

  /// Manual stock increase (e.g., found inventory, count correction)
  stockAdjustmentIn('stock_adjustment_in', 'Stock Adjustment In', true),

  /// Manual stock decrease (e.g., count correction)
  stockAdjustmentOut('stock_adjustment_out', 'Stock Adjustment Out', false),

  /// Damaged goods removed from inventory
  damagedOut('damaged_out', 'Damaged', false),

  /// Expired goods removed from inventory
  expiredOut('expired_out', 'Expired', false);

  const MovementType(this.value, this.displayName, this.shouldBePositive);

  /// Database enum value
  final String value;

  /// Human-readable display name
  final String displayName;

  /// Whether quantity_change should be positive for this movement type
  final bool shouldBePositive;

  /// Parse from database string value
  static MovementType fromString(String value) {
    return MovementType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => throw ArgumentError('Invalid movement type: $value'),
    );
  }

  /// Validate that quantity has the correct sign for this movement type
  bool isValidQuantity(int quantity) {
    if (shouldBePositive) {
      return quantity > 0;
    } else {
      return quantity < 0;
    }
  }

  /// Get the absolute value description (for display)
  String getQuantityDescription(int quantity) {
    final absValue = quantity.abs();
    if (shouldBePositive) {
      return '+$absValue';
    } else {
      return '-$absValue';
    }
  }
}
