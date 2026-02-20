// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_item.freezed.dart';
part 'sale_item.g.dart';

@freezed
class SaleItem with _$SaleItem {
  const factory SaleItem({
    String? id,
    @JsonKey(name: 'sale_id') required String saleId,
    @JsonKey(name: 'product_id') required String productId,
    required int quantity,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'total_price') required double totalPrice,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _SaleItem;

  factory SaleItem.fromJson(Map<String, dynamic> json) =>
      _$SaleItemFromJson(json);
}
