import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mock_items_manager/app/feats/auth/data/datasource/datasource_impl/file_auth_datasource.dart';
import 'package:mock_items_manager/app/feats/auth/data/datasource/i_auth_datasource.dart';
import 'package:mock_items_manager/app/feats/auth/data/repository_impl/auth_repository.dart';
import 'package:mock_items_manager/app/feats/auth/domain/repository/i_auth_repository.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/datasources/datasource_impl/file_dashboard_datasource.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/datasources/i_dashboard_datasource.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/repository_impl/dashboard_repository.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:path_provider/path_provider.dart';

final _serviceLocator = GetIt.instance;

Future<void> init() async {
  final directory = await getApplicationCacheDirectory();
  final path = directory.path;
  final authStorageFile = File('$path/auth_storage.json');
  final dashboardStorageFile = File('$path/dashboard_storage.json');
  if (!(await authStorageFile.exists())) {
    await authStorageFile.writeAsString('[]');
    await dashboardStorageFile.writeAsString('[]');
  }

  _serviceLocator.registerLazySingleton<IAuthDatasource>(
    () => FileAuthDatasource(storage: authStorageFile),
  );
  _serviceLocator.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(
      authDatasource: _serviceLocator(),
    ),
  );

  _serviceLocator.registerLazySingleton<IDashboardDatasource>(
    () => FileDashboardDatasource(
      storage: dashboardStorageFile,
    ),
  );
  _serviceLocator.registerLazySingleton<IDashboardRepository>(
    () => DashboardRepository(
      dashboardDatasource: _serviceLocator(),
    ),
  );
}
