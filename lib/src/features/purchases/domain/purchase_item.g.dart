// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseItemImpl _$$PurchaseItemImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseItemImpl(
      id: json['id'] as String?,
      purchaseId: json['purchase_id'] as String,
      productId: json['product_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$PurchaseItemImplToJson(_$PurchaseItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchase_id': instance.purchaseId,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'total_price': instance.totalPrice,
      'created_at': instance.createdAt?.toIso8601String(),
    };
