// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return _Purchase.fromJson(json);
}

/// @nodoc
mixin _$Purchase {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_id')
  String get supplierId => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  String get branchId => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_date')
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_number')
  String? get invoiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  double get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(
    name: 'payment_status',
    fromJson: _paymentStatusFromJson,
    toJson: _paymentStatusToJson,
  )
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Purchase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseCopyWith<Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseCopyWith<$Res> {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) then) =
      _$PurchaseCopyWithImpl<$Res, Purchase>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'supplier_id') String supplierId,
    @JsonKey(name: 'branch_id') String branchId,
    @JsonKey(name: 'purchase_date') DateTime purchaseDate,
    @JsonKey(name: 'invoice_number') String? invoiceNumber,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(name: 'paid_amount') double paidAmount,
    @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromJson,
      toJson: _paymentStatusToJson,
    )
    PaymentStatus paymentStatus,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$PurchaseCopyWithImpl<$Res, $Val extends Purchase>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? supplierId = null,
    Object? branchId = null,
    Object? purchaseDate = null,
    Object? invoiceNumber = freezed,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? paymentStatus = null,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            supplierId: null == supplierId
                ? _value.supplierId
                : supplierId // ignore: cast_nullable_to_non_nullable
                      as String,
            branchId: null == branchId
                ? _value.branchId
                : branchId // ignore: cast_nullable_to_non_nullable
                      as String,
            purchaseDate: null == purchaseDate
                ? _value.purchaseDate
                : purchaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            invoiceNumber: freezed == invoiceNumber
                ? _value.invoiceNumber
                : invoiceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            paidAmount: null == paidAmount
                ? _value.paidAmount
                : paidAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentStatus: null == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                      as PaymentStatus,
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
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchaseImplCopyWith<$Res>
    implements $PurchaseCopyWith<$Res> {
  factory _$$PurchaseImplCopyWith(
    _$PurchaseImpl value,
    $Res Function(_$PurchaseImpl) then,
  ) = __$$PurchaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'supplier_id') String supplierId,
    @JsonKey(name: 'branch_id') String branchId,
    @JsonKey(name: 'purchase_date') DateTime purchaseDate,
    @JsonKey(name: 'invoice_number') String? invoiceNumber,
    @JsonKey(name: 'total_amount') double totalAmount,
    @JsonKey(name: 'paid_amount') double paidAmount,
    @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromJson,
      toJson: _paymentStatusToJson,
    )
    PaymentStatus paymentStatus,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$PurchaseImplCopyWithImpl<$Res>
    extends _$PurchaseCopyWithImpl<$Res, _$PurchaseImpl>
    implements _$$PurchaseImplCopyWith<$Res> {
  __$$PurchaseImplCopyWithImpl(
    _$PurchaseImpl _value,
    $Res Function(_$PurchaseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? supplierId = null,
    Object? branchId = null,
    Object? purchaseDate = null,
    Object? invoiceNumber = freezed,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? paymentStatus = null,
    Object? notes = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PurchaseImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        supplierId: null == supplierId
            ? _value.supplierId
            : supplierId // ignore: cast_nullable_to_non_nullable
                  as String,
        branchId: null == branchId
            ? _value.branchId
            : branchId // ignore: cast_nullable_to_non_nullable
                  as String,
        purchaseDate: null == purchaseDate
            ? _value.purchaseDate
            : purchaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        invoiceNumber: freezed == invoiceNumber
            ? _value.invoiceNumber
            : invoiceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        paidAmount: null == paidAmount
            ? _value.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentStatus: null == paymentStatus
            ? _value.paymentStatus
            : paymentStatus // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
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
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseImpl implements _Purchase {
  const _$PurchaseImpl({
    this.id,
    @JsonKey(name: 'supplier_id') required this.supplierId,
    @JsonKey(name: 'branch_id') required this.branchId,
    @JsonKey(name: 'purchase_date') required this.purchaseDate,
    @JsonKey(name: 'invoice_number') this.invoiceNumber,
    @JsonKey(name: 'total_amount') required this.totalAmount,
    @JsonKey(name: 'paid_amount') this.paidAmount = 0.0,
    @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromJson,
      toJson: _paymentStatusToJson,
    )
    this.paymentStatus = PaymentStatus.unpaid,
    this.notes,
    @JsonKey(name: 'created_by') this.createdBy,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$PurchaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'supplier_id')
  final String supplierId;
  @override
  @JsonKey(name: 'branch_id')
  final String branchId;
  @override
  @JsonKey(name: 'purchase_date')
  final DateTime purchaseDate;
  @override
  @JsonKey(name: 'invoice_number')
  final String? invoiceNumber;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'paid_amount')
  final double paidAmount;
  @override
  @JsonKey(
    name: 'payment_status',
    fromJson: _paymentStatusFromJson,
    toJson: _paymentStatusToJson,
  )
  final PaymentStatus paymentStatus;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Purchase(id: $id, supplierId: $supplierId, branchId: $branchId, purchaseDate: $purchaseDate, invoiceNumber: $invoiceNumber, totalAmount: $totalAmount, paidAmount: $paidAmount, paymentStatus: $paymentStatus, notes: $notes, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    supplierId,
    branchId,
    purchaseDate,
    invoiceNumber,
    totalAmount,
    paidAmount,
    paymentStatus,
    notes,
    createdBy,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      __$$PurchaseImplCopyWithImpl<_$PurchaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseImplToJson(this);
  }
}

abstract class _Purchase implements Purchase {
  const factory _Purchase({
    final String? id,
    @JsonKey(name: 'supplier_id') required final String supplierId,
    @JsonKey(name: 'branch_id') required final String branchId,
    @JsonKey(name: 'purchase_date') required final DateTime purchaseDate,
    @JsonKey(name: 'invoice_number') final String? invoiceNumber,
    @JsonKey(name: 'total_amount') required final double totalAmount,
    @JsonKey(name: 'paid_amount') final double paidAmount,
    @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromJson,
      toJson: _paymentStatusToJson,
    )
    final PaymentStatus paymentStatus,
    final String? notes,
    @JsonKey(name: 'created_by') final String? createdBy,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$PurchaseImpl;

  factory _Purchase.fromJson(Map<String, dynamic> json) =
      _$PurchaseImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'supplier_id')
  String get supplierId;
  @override
  @JsonKey(name: 'branch_id')
  String get branchId;
  @override
  @JsonKey(name: 'purchase_date')
  DateTime get purchaseDate;
  @override
  @JsonKey(name: 'invoice_number')
  String? get invoiceNumber;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'paid_amount')
  double get paidAmount;
  @override
  @JsonKey(
    name: 'payment_status',
    fromJson: _paymentStatusFromJson,
    toJson: _paymentStatusToJson,
  )
  PaymentStatus get paymentStatus;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
