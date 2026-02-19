// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PurchaseItem _$PurchaseItemFromJson(Map<String, dynamic> json) {
  return _PurchaseItem.fromJson(json);
}

/// @nodoc
mixin _$PurchaseItem {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_id')
  String get purchaseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  double get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_price')
  double get totalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PurchaseItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseItemCopyWith<PurchaseItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseItemCopyWith<$Res> {
  factory $PurchaseItemCopyWith(
    PurchaseItem value,
    $Res Function(PurchaseItem) then,
  ) = _$PurchaseItemCopyWithImpl<$Res, PurchaseItem>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'purchase_id') String purchaseId,
    @JsonKey(name: 'product_id') String productId,
    int quantity,
    @JsonKey(name: 'unit_price') double unitPrice,
    @JsonKey(name: 'total_price') double totalPrice,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$PurchaseItemCopyWithImpl<$Res, $Val extends PurchaseItem>
    implements $PurchaseItemCopyWith<$Res> {
  _$PurchaseItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? purchaseId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalPrice = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            purchaseId: null == purchaseId
                ? _value.purchaseId
                : purchaseId // ignore: cast_nullable_to_non_nullable
                      as String,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as double,
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
abstract class _$$PurchaseItemImplCopyWith<$Res>
    implements $PurchaseItemCopyWith<$Res> {
  factory _$$PurchaseItemImplCopyWith(
    _$PurchaseItemImpl value,
    $Res Function(_$PurchaseItemImpl) then,
  ) = __$$PurchaseItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'purchase_id') String purchaseId,
    @JsonKey(name: 'product_id') String productId,
    int quantity,
    @JsonKey(name: 'unit_price') double unitPrice,
    @JsonKey(name: 'total_price') double totalPrice,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$PurchaseItemImplCopyWithImpl<$Res>
    extends _$PurchaseItemCopyWithImpl<$Res, _$PurchaseItemImpl>
    implements _$$PurchaseItemImplCopyWith<$Res> {
  __$$PurchaseItemImplCopyWithImpl(
    _$PurchaseItemImpl _value,
    $Res Function(_$PurchaseItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? purchaseId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalPrice = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PurchaseItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        purchaseId: null == purchaseId
            ? _value.purchaseId
            : purchaseId // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as double,
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
class _$PurchaseItemImpl implements _PurchaseItem {
  const _$PurchaseItemImpl({
    this.id,
    @JsonKey(name: 'purchase_id') required this.purchaseId,
    @JsonKey(name: 'product_id') required this.productId,
    required this.quantity,
    @JsonKey(name: 'unit_price') required this.unitPrice,
    @JsonKey(name: 'total_price') required this.totalPrice,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$PurchaseItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseItemImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'purchase_id')
  final String purchaseId;
  @override
  @JsonKey(name: 'product_id')
  final String productId;
  @override
  final int quantity;
  @override
  @JsonKey(name: 'unit_price')
  final double unitPrice;
  @override
  @JsonKey(name: 'total_price')
  final double totalPrice;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PurchaseItem(id: $id, purchaseId: $purchaseId, productId: $productId, quantity: $quantity, unitPrice: $unitPrice, totalPrice: $totalPrice, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.purchaseId, purchaseId) ||
                other.purchaseId == purchaseId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    purchaseId,
    productId,
    quantity,
    unitPrice,
    totalPrice,
    createdAt,
  );

  /// Create a copy of PurchaseItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseItemImplCopyWith<_$PurchaseItemImpl> get copyWith =>
      __$$PurchaseItemImplCopyWithImpl<_$PurchaseItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseItemImplToJson(this);
  }
}

abstract class _PurchaseItem implements PurchaseItem {
  const factory _PurchaseItem({
    final String? id,
    @JsonKey(name: 'purchase_id') required final String purchaseId,
    @JsonKey(name: 'product_id') required final String productId,
    required final int quantity,
    @JsonKey(name: 'unit_price') required final double unitPrice,
    @JsonKey(name: 'total_price') required final double totalPrice,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$PurchaseItemImpl;

  factory _PurchaseItem.fromJson(Map<String, dynamic> json) =
      _$PurchaseItemImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'purchase_id')
  String get purchaseId;
  @override
  @JsonKey(name: 'product_id')
  String get productId;
  @override
  int get quantity;
  @override
  @JsonKey(name: 'unit_price')
  double get unitPrice;
  @override
  @JsonKey(name: 'total_price')
  double get totalPrice;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of PurchaseItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseItemImplCopyWith<_$PurchaseItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
