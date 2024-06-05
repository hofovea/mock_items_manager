import 'dart:io';

import 'package:mock_items_manager/app/feats/dashboard/data/datasources/i_dashboard_datasource.dart';

class FileDashboardDatasource implements IDashboardDatasource {
  final File _storage;

  FileDashboardDatasource({required File storage}) : _storage = storage;
}
