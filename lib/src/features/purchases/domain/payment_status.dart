/// Payment status for purchases
enum PaymentStatus {
  unpaid('unpaid', 'Unpaid'),
  partial('partial', 'Partially Paid'),
  paid('paid', 'Paid');

  const PaymentStatus(this.value, this.displayName);

  final String value;
  final String displayName;

  static PaymentStatus fromString(String value) {
    return PaymentStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => PaymentStatus.unpaid,
    );
  }
}
