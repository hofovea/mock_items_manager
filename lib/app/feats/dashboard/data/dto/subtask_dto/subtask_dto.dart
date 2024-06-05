// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/subtask/subtask.dart';

part 'subtask_dto.freezed.dart';

part 'subtask_dto.g.dart';

@freezed
class SubtaskDto with _$SubtaskDto {
  const factory SubtaskDto({
    String? title,
    String? description,
  }) = _SubtaskDto;

  const SubtaskDto._();

  factory SubtaskDto.fromEntity(Subtask entity) {
    return SubtaskDto(title: entity.title, description: entity.description);
  }

  factory SubtaskDto.fromJson(Map<String, dynamic> json) => _$SubtaskDtoFromJson(json);

  Subtask toEntity() => Subtask(title: title ?? '', description: description ?? '');
}
