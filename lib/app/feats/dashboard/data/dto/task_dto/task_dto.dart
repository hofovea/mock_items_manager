// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/data/dto/subtask_dto/subtask_dto.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';

part 'task_dto.freezed.dart';

part 'task_dto.g.dart';

@freezed
class TaskDto with _$TaskDto {
  const factory TaskDto({
    String? title,
    String? status,
    List<SubtaskDto>? subtasks,
  }) = _TaskDto;

  const TaskDto._();

  factory TaskDto.fromEntity(Task entity) {
    final dtoList =
        entity.subtasks.map((subtaskEntity) => SubtaskDto.fromEntity(subtaskEntity)).toList();
    return TaskDto(title: entity.title, status: entity.status.value, subtasks: dtoList);
  }

  factory TaskDto.fromJson(Map<String, dynamic> json) => _$TaskDtoFromJson(json);

  TaskStatus get taskStatus => switch (status) {
        'TODO' => TaskStatus.todo,
        'IN_PROGRESS' => TaskStatus.inProgress,
        'DONE' => TaskStatus.done,
        _ => TaskStatus.todo,
      };

  Task toEntity() {
    return Task(
      title: title ?? '',
      status: taskStatus,
      subtasks: subtasks?.map((subtaskDto) => subtaskDto.toEntity()).toList() ?? [],
    );
  }
}
