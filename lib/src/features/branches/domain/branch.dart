// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch.freezed.dart';
part 'branch.g.dart';

@freezed
class Branch with _$Branch {
  const factory Branch({
    String? id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    required String name,
    String? location,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Branch;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
}
