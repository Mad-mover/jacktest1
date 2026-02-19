// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseImpl _$$PurchaseImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseImpl(
      id: json['id'] as String?,
      supplierId: json['supplier_id'] as String,
      branchId: json['branch_id'] as String,
      purchaseDate: DateTime.parse(json['purchase_date'] as String),
      invoiceNumber: json['invoice_number'] as String?,
      totalAmount: (json['total_amount'] as num).toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble() ?? 0.0,
      paymentStatus: json['payment_status'] == null
          ? PaymentStatus.unpaid
          : _paymentStatusFromJson(json['payment_status'] as String),
      notes: json['notes'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PurchaseImplToJson(_$PurchaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplier_id': instance.supplierId,
      'branch_id': instance.branchId,
      'purchase_date': instance.purchaseDate.toIso8601String(),
      'invoice_number': instance.invoiceNumber,
      'total_amount': instance.totalAmount,
      'paid_amount': instance.paidAmount,
      'payment_status': _paymentStatusToJson(instance.paymentStatus),
      'notes': instance.notes,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
