// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cylinder_return.freezed.dart';
part 'cylinder_return.g.dart';

@freezed
class CylinderReturn with _$CylinderReturn {
  const factory CylinderReturn({
    String? id,
    @JsonKey(name: 'sale_id') required String saleId,
    @JsonKey(name: 'returned_product_id') required String returnedProductId,
    required int quantity,
    String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _CylinderReturn;

  factory CylinderReturn.fromJson(Map<String, dynamic> json) =>
      _$CylinderReturnFromJson(json);
}
