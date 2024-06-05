// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/auth/data/datasource/datasource_impl/file_auth_datasource.dart';
import 'package:mock_items_manager/app/feats/auth/data/datasource/i_auth_datasource.dart';
import 'package:mock_items_manager/app/feats/auth/data/repository_impl/auth_repository.dart';
import 'package:mock_items_manager/app/feats/auth/domain/repository/i_auth_repository.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/datasources/datasource_impl/file_dashboard_datasource.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/datasources/i_dashboard_datasource.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/repository_impl/dashboard_repository.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:mock_items_manager/core/services/file_service.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _registerServices();
  await GetIt.I.allReady();
}

Future<void> _registerServices() async {
  serviceLocator.registerSingletonAsync<FileService>(
    () async {
      final service = FileService();
      await service.init();
      return service;
    },
  );

  serviceLocator.registerLazySingleton<IAuthDatasource>(
    () => FileAuthDatasource(
      storage: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(
      authDatasource: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<IDashboardDatasource>(
    () => FileDashboardDatasource(
      storage: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<IDashboardRepository>(
    () => DashboardRepository(
      dashboardDatasource: serviceLocator(),
    ),
  );
}
