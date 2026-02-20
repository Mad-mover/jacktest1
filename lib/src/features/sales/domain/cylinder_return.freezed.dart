// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cylinder_return.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CylinderReturn _$CylinderReturnFromJson(Map<String, dynamic> json) {
  return _CylinderReturn.fromJson(json);
}

/// @nodoc
mixin _$CylinderReturn {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_id')
  String get saleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'returned_product_id')
  String get returnedProductId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CylinderReturn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CylinderReturn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CylinderReturnCopyWith<CylinderReturn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CylinderReturnCopyWith<$Res> {
  factory $CylinderReturnCopyWith(
    CylinderReturn value,
    $Res Function(CylinderReturn) then,
  ) = _$CylinderReturnCopyWithImpl<$Res, CylinderReturn>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'sale_id') String saleId,
    @JsonKey(name: 'returned_product_id') String returnedProductId,
    int quantity,
    String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$CylinderReturnCopyWithImpl<$Res, $Val extends CylinderReturn>
    implements $CylinderReturnCopyWith<$Res> {
  _$CylinderReturnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CylinderReturn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? saleId = null,
    Object? returnedProductId = null,
    Object? quantity = null,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            saleId: null == saleId
                ? _value.saleId
                : saleId // ignore: cast_nullable_to_non_nullable
                      as String,
            returnedProductId: null == returnedProductId
                ? _value.returnedProductId
                : returnedProductId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CylinderReturnImplCopyWith<$Res>
    implements $CylinderReturnCopyWith<$Res> {
  factory _$$CylinderReturnImplCopyWith(
    _$CylinderReturnImpl value,
    $Res Function(_$CylinderReturnImpl) then,
  ) = __$$CylinderReturnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'sale_id') String saleId,
    @JsonKey(name: 'returned_product_id') String returnedProductId,
    int quantity,
    String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$CylinderReturnImplCopyWithImpl<$Res>
    extends _$CylinderReturnCopyWithImpl<$Res, _$CylinderReturnImpl>
    implements _$$CylinderReturnImplCopyWith<$Res> {
  __$$CylinderReturnImplCopyWithImpl(
    _$CylinderReturnImpl _value,
    $Res Function(_$CylinderReturnImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CylinderReturn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? saleId = null,
    Object? returnedProductId = null,
    Object? quantity = null,
    Object? notes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$CylinderReturnImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        saleId: null == saleId
            ? _value.saleId
            : saleId // ignore: cast_nullable_to_non_nullable
                  as String,
        returnedProductId: null == returnedProductId
            ? _value.returnedProductId
            : returnedProductId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CylinderReturnImpl implements _CylinderReturn {
  const _$CylinderReturnImpl({
    this.id,
    @JsonKey(name: 'sale_id') required this.saleId,
    @JsonKey(name: 'returned_product_id') required this.returnedProductId,
    required this.quantity,
    this.notes,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$CylinderReturnImpl.fromJson(Map<String, dynamic> json) =>
      _$$CylinderReturnImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'sale_id')
  final String saleId;
  @override
  @JsonKey(name: 'returned_product_id')
  final String returnedProductId;
  @override
  final int quantity;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CylinderReturn(id: $id, saleId: $saleId, returnedProductId: $returnedProductId, quantity: $quantity, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CylinderReturnImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.returnedProductId, returnedProductId) ||
                other.returnedProductId == returnedProductId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    saleId,
    returnedProductId,
    quantity,
    notes,
    createdAt,
  );

  /// Create a copy of CylinderReturn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CylinderReturnImplCopyWith<_$CylinderReturnImpl> get copyWith =>
      __$$CylinderReturnImplCopyWithImpl<_$CylinderReturnImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CylinderReturnImplToJson(this);
  }
}

abstract class _CylinderReturn implements CylinderReturn {
  const factory _CylinderReturn({
    final String? id,
    @JsonKey(name: 'sale_id') required final String saleId,
    @JsonKey(name: 'returned_product_id')
    required final String returnedProductId,
    required final int quantity,
    final String? notes,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$CylinderReturnImpl;

  factory _CylinderReturn.fromJson(Map<String, dynamic> json) =
      _$CylinderReturnImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'sale_id')
  String get saleId;
  @override
  @JsonKey(name: 'returned_product_id')
  String get returnedProductId;
  @override
  int get quantity;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of CylinderReturn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CylinderReturnImplCopyWith<_$CylinderReturnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
