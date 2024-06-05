// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtask.freezed.dart';
part 'subtask.g.dart';

@freezed
class Subtask with _$Subtask {
  const factory Subtask({
    required String title,
    required String description,
  }) = _Subtask;

  factory Subtask.fromJson(Map<String, dynamic> json) => _$SubtaskFromJson(json);
}
