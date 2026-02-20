// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_method.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale {
  const factory Sale({
    String? id,
    @JsonKey(name: 'branch_id') required String branchId,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'rider_id') String? riderId,
    @JsonKey(name: 'sale_date') required DateTime saleDate,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(
      name: 'payment_method',
      fromJson: _paymentMethodFromJson,
      toJson: _paymentMethodToJson,
    )
    @Default(PaymentMethod.cash)
    PaymentMethod paymentMethod,
    @JsonKey(name: 'payment_reference') String? paymentReference,
    String? notes,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
}

PaymentMethod _paymentMethodFromJson(String value) =>
    PaymentMethod.fromString(value);
String _paymentMethodToJson(PaymentMethod method) => method.value;
