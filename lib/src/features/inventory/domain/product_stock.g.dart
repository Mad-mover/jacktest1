// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductStockImpl _$$ProductStockImplFromJson(Map<String, dynamic> json) =>
    _$ProductStockImpl(
      id: json['id'] as String?,
      productId: json['product_id'] as String,
      branchId: json['branch_id'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      lastUpdated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$$ProductStockImplToJson(_$ProductStockImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'product_id': instance.productId,
      'branch_id': instance.branchId,
      'quantity': instance.quantity,
      if (instance.lastUpdated?.toIso8601String() case final value?)
        'last_updated': value,
    };
