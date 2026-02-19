// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductStock _$ProductStockFromJson(Map<String, dynamic> json) {
  return _ProductStock.fromJson(json);
}

/// @nodoc
mixin _$ProductStock {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  String get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  String get branchId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated')
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this ProductStock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductStock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductStockCopyWith<ProductStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStockCopyWith<$Res> {
  factory $ProductStockCopyWith(
    ProductStock value,
    $Res Function(ProductStock) then,
  ) = _$ProductStockCopyWithImpl<$Res, ProductStock>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'product_id') String productId,
    @JsonKey(name: 'branch_id') String branchId,
    int quantity,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  });
}

/// @nodoc
class _$ProductStockCopyWithImpl<$Res, $Val extends ProductStock>
    implements $ProductStockCopyWith<$Res> {
  _$ProductStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductStock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = null,
    Object? branchId = null,
    Object? quantity = null,
    Object? lastUpdated = freezed,
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
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductStockImplCopyWith<$Res>
    implements $ProductStockCopyWith<$Res> {
  factory _$$ProductStockImplCopyWith(
    _$ProductStockImpl value,
    $Res Function(_$ProductStockImpl) then,
  ) = __$$ProductStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'product_id') String productId,
    @JsonKey(name: 'branch_id') String branchId,
    int quantity,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$ProductStockImplCopyWithImpl<$Res>
    extends _$ProductStockCopyWithImpl<$Res, _$ProductStockImpl>
    implements _$$ProductStockImplCopyWith<$Res> {
  __$$ProductStockImplCopyWithImpl(
    _$ProductStockImpl _value,
    $Res Function(_$ProductStockImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductStock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = null,
    Object? branchId = null,
    Object? quantity = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$ProductStockImpl(
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
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$ProductStockImpl implements _ProductStock {
  const _$ProductStockImpl({
    this.id,
    @JsonKey(name: 'product_id') required this.productId,
    @JsonKey(name: 'branch_id') required this.branchId,
    this.quantity = 0,
    @JsonKey(name: 'last_updated') this.lastUpdated,
  });

  factory _$ProductStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductStockImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'product_id')
  final String productId;
  @override
  @JsonKey(name: 'branch_id')
  final String branchId;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey(name: 'last_updated')
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'ProductStock(id: $id, productId: $productId, branchId: $branchId, quantity: $quantity, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductStockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, productId, branchId, quantity, lastUpdated);

  /// Create a copy of ProductStock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductStockImplCopyWith<_$ProductStockImpl> get copyWith =>
      __$$ProductStockImplCopyWithImpl<_$ProductStockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductStockImplToJson(this);
  }
}

abstract class _ProductStock implements ProductStock {
  const factory _ProductStock({
    final String? id,
    @JsonKey(name: 'product_id') required final String productId,
    @JsonKey(name: 'branch_id') required final String branchId,
    final int quantity,
    @JsonKey(name: 'last_updated') final DateTime? lastUpdated,
  }) = _$ProductStockImpl;

  factory _ProductStock.fromJson(Map<String, dynamic> json) =
      _$ProductStockImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'product_id')
  String get productId;
  @override
  @JsonKey(name: 'branch_id')
  String get branchId;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'last_updated')
  DateTime? get lastUpdated;

  /// Create a copy of ProductStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductStockImplCopyWith<_$ProductStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
