// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  String get branchId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'rider_id')
  String? get riderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_date')
  DateTime get saleDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(
    name: 'payment_method',
    fromJson: _paymentMethodFromJson,
    toJson: _paymentMethodToJson,
  )
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_reference')
  String? get paymentReference => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Sale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'branch_id') String branchId,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'rider_id') String? riderId,
    @JsonKey(name: 'sale_date') DateTime saleDate,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(
      name: 'payment_method',
      fromJson: _paymentMethodFromJson,
      toJson: _paymentMethodToJson,
    )
    PaymentMethod paymentMethod,
    @JsonKey(name: 'payment_reference') String? paymentReference,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? branchId = null,
    Object? customerId = freezed,
    Object? riderId = freezed,
    Object? saleDate = null,
    Object? totalAmount = null,
    Object? paymentMethod = null,
    Object? paymentReference = freezed,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            branchId: null == branchId
                ? _value.branchId
                : branchId // ignore: cast_nullable_to_non_nullable
                      as String,
            customerId: freezed == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            riderId: freezed == riderId
                ? _value.riderId
                : riderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            saleDate: null == saleDate
                ? _value.saleDate
                : saleDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            paymentReference: freezed == paymentReference
                ? _value.paymentReference
                : paymentReference // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleImplCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$SaleImplCopyWith(
    _$SaleImpl value,
    $Res Function(_$SaleImpl) then,
  ) = __$$SaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'branch_id') String branchId,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'rider_id') String? riderId,
    @JsonKey(name: 'sale_date') DateTime saleDate,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(
      name: 'payment_method',
      fromJson: _paymentMethodFromJson,
      toJson: _paymentMethodToJson,
    )
    PaymentMethod paymentMethod,
    @JsonKey(name: 'payment_reference') String? paymentReference,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$SaleImplCopyWithImpl<$Res>
    extends _$SaleCopyWithImpl<$Res, _$SaleImpl>
    implements _$$SaleImplCopyWith<$Res> {
  __$$SaleImplCopyWithImpl(_$SaleImpl _value, $Res Function(_$SaleImpl) _then)
    : super(_value, _then);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? branchId = null,
    Object? customerId = freezed,
    Object? riderId = freezed,
    Object? saleDate = null,
    Object? totalAmount = null,
    Object? paymentMethod = null,
    Object? paymentReference = freezed,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SaleImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        branchId: null == branchId
            ? _value.branchId
            : branchId // ignore: cast_nullable_to_non_nullable
                  as String,
        customerId: freezed == customerId
            ? _value.customerId
            : customerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        riderId: freezed == riderId
            ? _value.riderId
            : riderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        saleDate: null == saleDate
            ? _value.saleDate
            : saleDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        paymentReference: freezed == paymentReference
            ? _value.paymentReference
            : paymentReference // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleImpl implements _Sale {
  const _$SaleImpl({
    this.id,
    @JsonKey(name: 'branch_id') required this.branchId,
    @JsonKey(name: 'customer_id') this.customerId,
    @JsonKey(name: 'rider_id') this.riderId,
    @JsonKey(name: 'sale_date') required this.saleDate,
    @JsonKey(name: 'total_amount') required this.totalAmount,
    @JsonKey(
      name: 'payment_method',
      fromJson: _paymentMethodFromJson,
      toJson: _paymentMethodToJson,
    )
    this.paymentMethod = PaymentMethod.cash,
    @JsonKey(name: 'payment_reference') this.paymentReference,
    this.notes,
    @JsonKey(name: 'created_by') this.createdBy,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$SaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'branch_id')
  final String branchId;
  @override
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @override
  @JsonKey(name: 'rider_id')
  final String? riderId;
  @override
  @JsonKey(name: 'sale_date')
  final DateTime saleDate;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(
    name: 'payment_method',
    fromJson: _paymentMethodFromJson,
    toJson: _paymentMethodToJson,
  )
  final PaymentMethod paymentMethod;
  @override
  @JsonKey(name: 'payment_reference')
  final String? paymentReference;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Sale(id: $id, branchId: $branchId, customerId: $customerId, riderId: $riderId, saleDate: $saleDate, totalAmount: $totalAmount, paymentMethod: $paymentMethod, paymentReference: $paymentReference, notes: $notes, createdBy: $createdBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.riderId, riderId) || other.riderId == riderId) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentReference, paymentReference) ||
                other.paymentReference == paymentReference) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    branchId,
    customerId,
    riderId,
    saleDate,
    totalAmount,
    paymentMethod,
    paymentReference,
    notes,
    createdBy,
    createdAt,
  );

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      __$$SaleImplCopyWithImpl<_$SaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleImplToJson(this);
  }
}

abstract class _Sale implements Sale {
  const factory _Sale({
    final String? id,
    @JsonKey(name: 'branch_id') required final String branchId,
    @JsonKey(name: 'customer_id') final String? customerId,
    @JsonKey(name: 'rider_id') final String? riderId,
    @JsonKey(name: 'sale_date') required final DateTime saleDate,
    @JsonKey(name: 'total_amount') required final double totalAmount,
    @JsonKey(
      name: 'payment_method',
      fromJson: _paymentMethodFromJson,
      toJson: _paymentMethodToJson,
    )
    final PaymentMethod paymentMethod,
    @JsonKey(name: 'payment_reference') final String? paymentReference,
    final String? notes,
    @JsonKey(name: 'created_by') final String? createdBy,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$SaleImpl;

  factory _Sale.fromJson(Map<String, dynamic> json) = _$SaleImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'branch_id')
  String get branchId;
  @override
  @JsonKey(name: 'customer_id')
  String? get customerId;
  @override
  @JsonKey(name: 'rider_id')
  String? get riderId;
  @override
  @JsonKey(name: 'sale_date')
  DateTime get saleDate;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(
    name: 'payment_method',
    fromJson: _paymentMethodFromJson,
    toJson: _paymentMethodToJson,
  )
  PaymentMethod get paymentMethod;
  @override
  @JsonKey(name: 'payment_reference')
  String? get paymentReference;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
