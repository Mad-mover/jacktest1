// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PurchasePayment _$PurchasePaymentFromJson(Map<String, dynamic> json) {
  return _PurchasePayment.fromJson(json);
}

/// @nodoc
mixin _$PurchasePayment {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_id')
  String get purchaseId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_date')
  DateTime get paymentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_number')
  String? get referenceNumber => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PurchasePayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchasePayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchasePaymentCopyWith<PurchasePayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasePaymentCopyWith<$Res> {
  factory $PurchasePaymentCopyWith(
    PurchasePayment value,
    $Res Function(PurchasePayment) then,
  ) = _$PurchasePaymentCopyWithImpl<$Res, PurchasePayment>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'purchase_id') String purchaseId,
    double amount,
    @JsonKey(name: 'payment_date') DateTime paymentDate,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'reference_number') String? referenceNumber,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$PurchasePaymentCopyWithImpl<$Res, $Val extends PurchasePayment>
    implements $PurchasePaymentCopyWith<$Res> {
  _$PurchasePaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchasePayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? purchaseId = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = freezed,
    Object? referenceNumber = freezed,
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
            purchaseId: null == purchaseId
                ? _value.purchaseId
                : purchaseId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentDate: null == paymentDate
                ? _value.paymentDate
                : paymentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String?,
            referenceNumber: freezed == referenceNumber
                ? _value.referenceNumber
                : referenceNumber // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PurchasePaymentImplCopyWith<$Res>
    implements $PurchasePaymentCopyWith<$Res> {
  factory _$$PurchasePaymentImplCopyWith(
    _$PurchasePaymentImpl value,
    $Res Function(_$PurchasePaymentImpl) then,
  ) = __$$PurchasePaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'purchase_id') String purchaseId,
    double amount,
    @JsonKey(name: 'payment_date') DateTime paymentDate,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'reference_number') String? referenceNumber,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$PurchasePaymentImplCopyWithImpl<$Res>
    extends _$PurchasePaymentCopyWithImpl<$Res, _$PurchasePaymentImpl>
    implements _$$PurchasePaymentImplCopyWith<$Res> {
  __$$PurchasePaymentImplCopyWithImpl(
    _$PurchasePaymentImpl _value,
    $Res Function(_$PurchasePaymentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchasePayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? purchaseId = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = freezed,
    Object? referenceNumber = freezed,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PurchasePaymentImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        purchaseId: null == purchaseId
            ? _value.purchaseId
            : purchaseId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentDate: null == paymentDate
            ? _value.paymentDate
            : paymentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String?,
        referenceNumber: freezed == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
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
class _$PurchasePaymentImpl implements _PurchasePayment {
  const _$PurchasePaymentImpl({
    this.id,
    @JsonKey(name: 'purchase_id') required this.purchaseId,
    required this.amount,
    @JsonKey(name: 'payment_date') required this.paymentDate,
    @JsonKey(name: 'payment_method') this.paymentMethod,
    @JsonKey(name: 'reference_number') this.referenceNumber,
    this.notes,
    @JsonKey(name: 'created_by') this.createdBy,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$PurchasePaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchasePaymentImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'purchase_id')
  final String purchaseId;
  @override
  final double amount;
  @override
  @JsonKey(name: 'payment_date')
  final DateTime paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'reference_number')
  final String? referenceNumber;
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
    return 'PurchasePayment(id: $id, purchaseId: $purchaseId, amount: $amount, paymentDate: $paymentDate, paymentMethod: $paymentMethod, referenceNumber: $referenceNumber, notes: $notes, createdBy: $createdBy, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasePaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.purchaseId, purchaseId) ||
                other.purchaseId == purchaseId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
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
    purchaseId,
    amount,
    paymentDate,
    paymentMethod,
    referenceNumber,
    notes,
    createdBy,
    createdAt,
  );

  /// Create a copy of PurchasePayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasePaymentImplCopyWith<_$PurchasePaymentImpl> get copyWith =>
      __$$PurchasePaymentImplCopyWithImpl<_$PurchasePaymentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchasePaymentImplToJson(this);
  }
}

abstract class _PurchasePayment implements PurchasePayment {
  const factory _PurchasePayment({
    final String? id,
    @JsonKey(name: 'purchase_id') required final String purchaseId,
    required final double amount,
    @JsonKey(name: 'payment_date') required final DateTime paymentDate,
    @JsonKey(name: 'payment_method') final String? paymentMethod,
    @JsonKey(name: 'reference_number') final String? referenceNumber,
    final String? notes,
    @JsonKey(name: 'created_by') final String? createdBy,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$PurchasePaymentImpl;

  factory _PurchasePayment.fromJson(Map<String, dynamic> json) =
      _$PurchasePaymentImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'purchase_id')
  String get purchaseId;
  @override
  double get amount;
  @override
  @JsonKey(name: 'payment_date')
  DateTime get paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  @JsonKey(name: 'reference_number')
  String? get referenceNumber;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of PurchasePayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchasePaymentImplCopyWith<_$PurchasePaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
