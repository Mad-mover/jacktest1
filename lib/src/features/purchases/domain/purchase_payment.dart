// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_payment.freezed.dart';
part 'purchase_payment.g.dart';

@freezed
class PurchasePayment with _$PurchasePayment {
  const factory PurchasePayment({
    String? id,
    @JsonKey(name: 'purchase_id') required String purchaseId,
    required double amount,
    @JsonKey(name: 'payment_date') required DateTime paymentDate,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'reference_number') String? referenceNumber,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _PurchasePayment;

  factory PurchasePayment.fromJson(Map<String, dynamic> json) =>
      _$PurchasePaymentFromJson(json);
}
