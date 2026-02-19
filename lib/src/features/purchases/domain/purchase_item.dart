// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_item.freezed.dart';
part 'purchase_item.g.dart';

@freezed
class PurchaseItem with _$PurchaseItem {
  const factory PurchaseItem({
    String? id,
    @JsonKey(name: 'purchase_id') required String purchaseId,
    @JsonKey(name: 'product_id') required String productId,
    required int quantity,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'total_price') required double totalPrice,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _PurchaseItem;

  factory PurchaseItem.fromJson(Map<String, dynamic> json) =>
      _$PurchaseItemFromJson(json);
}
