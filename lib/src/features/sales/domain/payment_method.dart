/// Payment methods for sales
enum PaymentMethod {
  cash('cash', 'Cash', false),
  mpesa('mpesa', 'M-Pesa', true),
  pdq('pdq', 'PDQ / Card', true),
  cheque('cheque', 'Cheque', true),
  notPaid('not_paid', 'Not Paid', false);

  const PaymentMethod(this.value, this.displayName, this.requiresReference);

  /// Database value
  final String value;

  /// Human-readable label
  final String displayName;

  /// Whether a reference / cheque number is required
  final bool requiresReference;

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (m) => m.value == value,
      orElse: () => PaymentMethod.cash,
    );
  }
}
