// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RiderImpl _$$RiderImplFromJson(Map<String, dynamic> json) => _$RiderImpl(
  id: json['id'] as String?,
  name: json['name'] as String,
  phone: json['phone'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$RiderImplToJson(_$RiderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
    };
