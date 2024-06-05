// Dart imports:
import 'dart:convert';
import 'dart:math';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/data/datasources/i_dashboard_datasource.dart';
import 'package:mock_items_manager/app/feats/dashboard/data/dto/task_dto/task_dto.dart';
import 'package:mock_items_manager/core/exceptions/exceptions.dart';
import 'package:mock_items_manager/core/services/file_service.dart';

class FileDashboardDatasource implements IDashboardDatasource {
  final FileService _storage;

  FileDashboardDatasource({required FileService storage}) : _storage = storage;

  Future<void> _mockDelay() async {
    await Future.delayed(
      Duration(milliseconds: Random().nextInt(1000) + 500),
    );
  }

  @override
  Future<List<TaskDto>> loadDashboard() async {
    await _mockDelay();
    final storageContent = await _storage.dashboardStorageFile.readAsString();
    final jsonDataList = await jsonDecode(storageContent) as List<dynamic>;
    final errorFactor = Random().nextDouble() * 100;
    if (errorFactor < 25) {
      return jsonDataList.map((jsonItem) => TaskDto.fromJson(jsonItem)).toList();
    } else if (errorFactor >= 25 && errorFactor < 50) {
      throw InvalidDataException();
    } else if (errorFactor >= 50 && errorFactor < 75) {
      throw ServerInternalException();
    } else {
      throw UnknownException();
    }
  }

  @override
  Future<void> saveChanges(List<TaskDto> tasksList) async {
    await _mockDelay();

    await _storage.dashboardStorageFile.writeAsString(
      jsonEncode(
        tasksList.map((item) => item.toJson()).toList(),
      ),
    );
  }
}
