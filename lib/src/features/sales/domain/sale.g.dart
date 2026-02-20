// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleImpl _$$SaleImplFromJson(Map<String, dynamic> json) => _$SaleImpl(
  id: json['id'] as String?,
  branchId: json['branch_id'] as String,
  customerId: json['customer_id'] as String?,
  riderId: json['rider_id'] as String?,
  saleDate: DateTime.parse(json['sale_date'] as String),
  totalAmount: (json['total_amount'] as num).toDouble(),
  paymentMethod: json['payment_method'] == null
      ? PaymentMethod.cash
      : _paymentMethodFromJson(json['payment_method'] as String),
  paymentReference: json['payment_reference'] as String?,
  notes: json['notes'] as String?,
  createdBy: json['created_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$SaleImplToJson(_$SaleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'customer_id': instance.customerId,
      'rider_id': instance.riderId,
      'sale_date': instance.saleDate.toIso8601String(),
      'total_amount': instance.totalAmount,
      'payment_method': _paymentMethodToJson(instance.paymentMethod),
      'payment_reference': instance.paymentReference,
      'notes': instance.notes,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
    };
