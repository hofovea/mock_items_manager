// Package imports:
import 'package:fpdart/fpdart.dart' hide Task;

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/core/failures/failures.dart';

abstract interface class IDashboardRepository {
  Future<Either<Failure, List<Task>>> loadDashboard();

  Future<Either<Failure, void>> saveChanges(List<Task> tasksList);
}
