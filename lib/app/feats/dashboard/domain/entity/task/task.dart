import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String title,
    required TaskStatus status,
    List<Task>? subtasks,
  }) = _Task;

  const Task._();

  factory Task.asSubtask({
    required String title,
    required TaskStatus status,
  }) {
    return Task(title: title, status: status, subtasks: null);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  bool get isSubtask => subtasks == null;
}

enum TaskStatus {
  todo('TODO'),
  inProgress('IN_PROGRESS'),
  done('DONE');

  final String value;

  const TaskStatus(this.value);
}
