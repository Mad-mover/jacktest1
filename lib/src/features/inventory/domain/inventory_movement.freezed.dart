// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_movement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InventoryMovement _$InventoryMovementFromJson(Map<String, dynamic> json) {
  return _InventoryMovement.fromJson(json);
}

/// @nodoc
mixin _$InventoryMovement {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  String get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  String get branchId => throw _privateConstructorUsedError;
  @JsonKey(
    name: 'movement_type',
    fromJson: _movementTypeFromJson,
    toJson: _movementTypeToJson,
  )
  MovementType get movementType => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity_change')
  int get quantityChange => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_id')
  String? get referenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_type')
  String? get referenceType => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'reversed_movement_id')
  String? get reversedMovementId => throw _privateConstructorUsedError;

  /// Serializes this InventoryMovement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryMovementCopyWith<InventoryMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryMovementCopyWith<$Res> {
  factory $InventoryMovementCopyWith(
    InventoryMovement value,
    $Res Function(InventoryMovement) then,
  ) = _$InventoryMovementCopyWithImpl<$Res, InventoryMovement>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'product_id') String productId,
    @JsonKey(name: 'branch_id') String branchId,
    @JsonKey(
      name: 'movement_type',
      fromJson: _movementTypeFromJson,
      toJson: _movementTypeToJson,
    )
    MovementType movementType,
    @JsonKey(name: 'quantity_change') int quantityChange,
    @JsonKey(name: 'reference_id') String? referenceId,
    @JsonKey(name: 'reference_type') String? referenceType,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'reversed_movement_id') String? reversedMovementId,
  });
}

/// @nodoc
class _$InventoryMovementCopyWithImpl<$Res, $Val extends InventoryMovement>
    implements $InventoryMovementCopyWith<$Res> {
  _$InventoryMovementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = null,
    Object? branchId = null,
    Object? movementType = null,
    Object? quantityChange = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? reversedMovementId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            branchId: null == branchId
                ? _value.branchId
                : branchId // ignore: cast_nullable_to_non_nullable
                      as String,
            movementType: null == movementType
                ? _value.movementType
                : movementType // ignore: cast_nullable_to_non_nullable
                      as MovementType,
            quantityChange: null == quantityChange
                ? _value.quantityChange
                : quantityChange // ignore: cast_nullable_to_non_nullable
                      as int,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            referenceType: freezed == referenceType
                ? _value.referenceType
                : referenceType // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            reversedMovementId: freezed == reversedMovementId
                ? _value.reversedMovementId
                : reversedMovementId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryMovementImplCopyWith<$Res>
    implements $InventoryMovementCopyWith<$Res> {
  factory _$$InventoryMovementImplCopyWith(
    _$InventoryMovementImpl value,
    $Res Function(_$InventoryMovementImpl) then,
  ) = __$$InventoryMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'product_id') String productId,
    @JsonKey(name: 'branch_id') String branchId,
    @JsonKey(
      name: 'movement_type',
      fromJson: _movementTypeFromJson,
      toJson: _movementTypeToJson,
    )
    MovementType movementType,
    @JsonKey(name: 'quantity_change') int quantityChange,
    @JsonKey(name: 'reference_id') String? referenceId,
    @JsonKey(name: 'reference_type') String? referenceType,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'reversed_movement_id') String? reversedMovementId,
  });
}

/// @nodoc
class __$$InventoryMovementImplCopyWithImpl<$Res>
    extends _$InventoryMovementCopyWithImpl<$Res, _$InventoryMovementImpl>
    implements _$$InventoryMovementImplCopyWith<$Res> {
  __$$InventoryMovementImplCopyWithImpl(
    _$InventoryMovementImpl _value,
    $Res Function(_$InventoryMovementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = null,
    Object? branchId = null,
    Object? movementType = null,
    Object? quantityChange = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? reversedMovementId = freezed,
  }) {
    return _then(
      _$InventoryMovementImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        branchId: null == branchId
            ? _value.branchId
            : branchId // ignore: cast_nullable_to_non_nullable
                  as String,
        movementType: null == movementType
            ? _value.movementType
            : movementType // ignore: cast_nullable_to_non_nullable
                  as MovementType,
        quantityChange: null == quantityChange
            ? _value.quantityChange
            : quantityChange // ignore: cast_nullable_to_non_nullable
                  as int,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        referenceType: freezed == referenceType
            ? _value.referenceType
            : referenceType // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        reversedMovementId: freezed == reversedMovementId
            ? _value.reversedMovementId
            : reversedMovementId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryMovementImpl implements _InventoryMovement {
  const _$InventoryMovementImpl({
    this.id,
    @JsonKey(name: 'product_id') required this.productId,
    @JsonKey(name: 'branch_id') required this.branchId,
    @JsonKey(
      name: 'movement_type',
      fromJson: _movementTypeFromJson,
      toJson: _movementTypeToJson,
    )
    required this.movementType,
    @JsonKey(name: 'quantity_change') required this.quantityChange,
    @JsonKey(name: 'reference_id') this.referenceId,
    @JsonKey(name: 'reference_type') this.referenceType,
    this.notes,
    @JsonKey(name: 'created_by') this.createdBy,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'reversed_movement_id') this.reversedMovementId,
  });

  factory _$InventoryMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryMovementImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'product_id')
  final String productId;
  @override
  @JsonKey(name: 'branch_id')
  final String branchId;
  @override
  @JsonKey(
    name: 'movement_type',
    fromJson: _movementTypeFromJson,
    toJson: _movementTypeToJson,
  )
  final MovementType movementType;
  @override
  @JsonKey(name: 'quantity_change')
  final int quantityChange;
  @override
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @override
  @JsonKey(name: 'reference_type')
  final String? referenceType;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'reversed_movement_id')
  final String? reversedMovementId;

  @override
  String toString() {
    return 'InventoryMovement(id: $id, productId: $productId, branchId: $branchId, movementType: $movementType, quantityChange: $quantityChange, referenceId: $referenceId, referenceType: $referenceType, notes: $notes, createdBy: $createdBy, createdAt: $createdAt, reversedMovementId: $reversedMovementId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            (identical(other.quantityChange, quantityChange) ||
                other.quantityChange == quantityChange) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.reversedMovementId, reversedMovementId) ||
                other.reversedMovementId == reversedMovementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    branchId,
    movementType,
    quantityChange,
    referenceId,
    referenceType,
    notes,
    createdBy,
    createdAt,
    reversedMovementId,
  );

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      __$$InventoryMovementImplCopyWithImpl<_$InventoryMovementImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryMovementImplToJson(this);
  }
}

abstract class _InventoryMovement implements InventoryMovement {
  const factory _InventoryMovement({
    final String? id,
    @JsonKey(name: 'product_id') required final String productId,
    @JsonKey(name: 'branch_id') required final String branchId,
    @JsonKey(
      name: 'movement_type',
      fromJson: _movementTypeFromJson,
      toJson: _movementTypeToJson,
    )
    required final MovementType movementType,
    @JsonKey(name: 'quantity_change') required final int quantityChange,
    @JsonKey(name: 'reference_id') final String? referenceId,
    @JsonKey(name: 'reference_type') final String? referenceType,
    final String? notes,
    @JsonKey(name: 'created_by') final String? createdBy,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'reversed_movement_id') final String? reversedMovementId,
  }) = _$InventoryMovementImpl;

  factory _InventoryMovement.fromJson(Map<String, dynamic> json) =
      _$InventoryMovementImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'product_id')
  String get productId;
  @override
  @JsonKey(name: 'branch_id')
  String get branchId;
  @override
  @JsonKey(
    name: 'movement_type',
    fromJson: _movementTypeFromJson,
    toJson: _movementTypeToJson,
  )
  MovementType get movementType;
  @override
  @JsonKey(name: 'quantity_change')
  int get quantityChange;
  @override
  @JsonKey(name: 'reference_id')
  String? get referenceId;
  @override
  @JsonKey(name: 'reference_type')
  String? get referenceType;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'reversed_movement_id')
  String? get reversedMovementId;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
