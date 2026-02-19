// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_status.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
class Purchase with _$Purchase {
  const factory Purchase({
    String? id,
    @JsonKey(name: 'supplier_id') required String supplierId,
    @JsonKey(name: 'branch_id') required String branchId,
    @JsonKey(name: 'purchase_date') required DateTime purchaseDate,
    @JsonKey(name: 'invoice_number') String? invoiceNumber,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'paid_amount') @Default(0.0) double paidAmount,
    @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromJson,
      toJson: _paymentStatusToJson,
    )
    @Default(PaymentStatus.unpaid)
    PaymentStatus paymentStatus,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
}

PaymentStatus _paymentStatusFromJson(String value) =>
    PaymentStatus.fromString(value);
String _paymentStatusToJson(PaymentStatus status) => status.value;
