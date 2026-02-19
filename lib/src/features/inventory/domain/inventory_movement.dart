// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'movement_type.dart';

part 'inventory_movement.freezed.dart';
part 'inventory_movement.g.dart';

@freezed
class InventoryMovement with _$InventoryMovement {
  const factory InventoryMovement({
    String? id,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'branch_id') required String branchId,
    @JsonKey(
      name: 'movement_type',
      fromJson: _movementTypeFromJson,
      toJson: _movementTypeToJson,
    )
    required MovementType movementType,
    @JsonKey(name: 'quantity_change') required int quantityChange,
    @JsonKey(name: 'reference_id') String? referenceId,
    @JsonKey(name: 'reference_type') String? referenceType,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'reversed_movement_id') String? reversedMovementId,
  }) = _InventoryMovement;

  factory InventoryMovement.fromJson(Map<String, dynamic> json) =>
      _$InventoryMovementFromJson(json);
}

// Custom JSON converters for MovementType enum
MovementType _movementTypeFromJson(String value) =>
    MovementType.fromString(value);
String _movementTypeToJson(MovementType type) => type.value;
