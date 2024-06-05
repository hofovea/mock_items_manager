// Package imports:
import 'package:fpdart/fpdart.dart' hide Task;

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/data/datasources/i_dashboard_datasource.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/dto/task_dto/task_dto.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:mock_items_manager/core/exceptions/exceptions.dart';
import 'package:mock_items_manager/core/failures/failures.dart';

class DashboardRepository implements IDashboardRepository {
  final IDashboardDatasource _dashboardDatasource;

  DashboardRepository({
    required IDashboardDatasource dashboardDatasource,
  }) : _dashboardDatasource = dashboardDatasource;

  @override
  Future<Either<Failure, List<Task>>> loadDashboard() async {
    try {
      final dtoList = await _dashboardDatasource.loadDashboard();
      return Right(dtoList.map((e) => e.toEntity()).toList());
    } on InvalidDataException {
      return Left(InvalidResponseFailure());
    } on ServerInternalException {
      return Left(ServerInternalFailure());
    } on UnknownException {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveChanges(List<Task> tasksList) async {
    try {
      return Right(
        await _dashboardDatasource.saveChanges(
          tasksList.map((e) => TaskDto.fromEntity(e)).toList(),
        ),
      );
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
