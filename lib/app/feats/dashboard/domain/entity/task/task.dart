// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/subtask/subtask.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String title,
    required TaskStatus status,
    @Default(<Subtask>[])List<Subtask> subtasks,
  }) = _Task;

  const Task._();

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

enum TaskStatus {
  todo('TODO'),
  inProgress('IN_PROGRESS'),
  done('DONE');

  final String value;

  const TaskStatus(this.value);
}
