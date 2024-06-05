// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/data/dto/task_dto/task_dto.dart';

abstract interface class IDashboardDatasource {
  Future<List<TaskDto>> loadDashboard();

  Future<void> saveChanges(List<TaskDto> tasksList);
}
