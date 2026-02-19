// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchasePaymentImpl _$$PurchasePaymentImplFromJson(
  Map<String, dynamic> json,
) => _$PurchasePaymentImpl(
  id: json['id'] as String?,
  purchaseId: json['purchase_id'] as String,
  amount: (json['amount'] as num).toDouble(),
  paymentDate: DateTime.parse(json['payment_date'] as String),
  paymentMethod: json['payment_method'] as String?,
  referenceNumber: json['reference_number'] as String?,
  notes: json['notes'] as String?,
  createdBy: json['created_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$PurchasePaymentImplToJson(
  _$PurchasePaymentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'purchase_id': instance.purchaseId,
  'amount': instance.amount,
  'payment_date': instance.paymentDate.toIso8601String(),
  'payment_method': instance.paymentMethod,
  'reference_number': instance.referenceNumber,
  'notes': instance.notes,
  'created_by': instance.createdBy,
  'created_at': instance.createdAt?.toIso8601String(),
};
