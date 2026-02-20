// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cylinder_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CylinderReturnImpl _$$CylinderReturnImplFromJson(Map<String, dynamic> json) =>
    _$CylinderReturnImpl(
      id: json['id'] as String?,
      saleId: json['sale_id'] as String,
      returnedProductId: json['returned_product_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CylinderReturnImplToJson(
  _$CylinderReturnImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sale_id': instance.saleId,
  'returned_product_id': instance.returnedProductId,
  'quantity': instance.quantity,
  'notes': instance.notes,
  'created_at': instance.createdAt?.toIso8601String(),
};
