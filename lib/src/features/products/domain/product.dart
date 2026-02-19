// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    String? id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    required String name,
    required String category, // LPG cylinder, refill, accessory, water
    required double price,
    String? description,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
