// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:path_provider/path_provider.dart';

class FileService {
  late final File authStorageFile;
  late final File dashboardStorageFile;

  Future<void> init() async {
    final directory = await getApplicationCacheDirectory();
    final path = directory.path;
    authStorageFile = File('$path/auth_storage.json');
    dashboardStorageFile = File('$path/dashboard_storage.json');
    if (!(await authStorageFile.exists())) {
      await authStorageFile.writeAsString('[]');
      await dashboardStorageFile.writeAsString('[]');
    }
  }
}
