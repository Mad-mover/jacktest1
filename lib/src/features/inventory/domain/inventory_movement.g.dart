// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryMovementImpl _$$InventoryMovementImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryMovementImpl(
  id: json['id'] as String?,
  productId: json['product_id'] as String,
  branchId: json['branch_id'] as String,
  movementType: _movementTypeFromJson(json['movement_type'] as String),
  quantityChange: (json['quantity_change'] as num).toInt(),
  referenceId: json['reference_id'] as String?,
  referenceType: json['reference_type'] as String?,
  notes: json['notes'] as String?,
  createdBy: json['created_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  reversedMovementId: json['reversed_movement_id'] as String?,
);

Map<String, dynamic> _$$InventoryMovementImplToJson(
  _$InventoryMovementImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'product_id': instance.productId,
  'branch_id': instance.branchId,
  'movement_type': _movementTypeToJson(instance.movementType),
  'quantity_change': instance.quantityChange,
  'reference_id': instance.referenceId,
  'reference_type': instance.referenceType,
  'notes': instance.notes,
  'created_by': instance.createdBy,
  'created_at': instance.createdAt?.toIso8601String(),
  'reversed_movement_id': instance.reversedMovementId,
};
