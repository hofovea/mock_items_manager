import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mock_items_manager/app/app.dart';
import 'package:mock_items_manager/utils/di/service_locator.dart' as service_locator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await service_locator.init();
  await GetIt.I.allReady();
  runApp(
    const MockItemsManagerApp(),
  );
}
