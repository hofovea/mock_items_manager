import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mock_items_manager/app/feats/dashboard/data/datasources/i_dashboard_datasource.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:mock_items_manager/core/failures/failures.dart';

class DashboardRepository implements IDashboardRepository {
  final IDashboardDatasource _dashboardDatasource;

  DashboardRepository({
    required IDashboardDatasource dashboardDatasource,
  }) : _dashboardDatasource = dashboardDatasource;

  @override
  Future<Either<Failure, void>> saveChanges(List<Task> tasksList) {
    // TODO: implement saveChanges
    throw UnimplementedError();
  }
}
