// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_stock.freezed.dart';
part 'product_stock.g.dart';

@freezed
class ProductStock with _$ProductStock {
  @JsonSerializable(includeIfNull: false)
  const factory ProductStock({
    String? id,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'branch_id') required String branchId,
    @Default(0) int quantity,
    @JsonKey(name: 'last_updated') DateTime? lastUpdated,
  }) = _ProductStock;

  factory ProductStock.fromJson(Map<String, dynamic> json) =>
      _$ProductStockFromJson(json);
}
