// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rider.freezed.dart';
part 'rider.g.dart';

@freezed
class Rider with _$Rider {
  const factory Rider({
    String? id,
    required String name,
    String? phone,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Rider;

  factory Rider.fromJson(Map<String, dynamic> json) => _$RiderFromJson(json);
}
