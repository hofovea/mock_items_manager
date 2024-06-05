// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mock_items_manager/app/app.dart';
import 'package:mock_items_manager/utils/di/service_locator.dart' as service_locator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await service_locator.init();
  runApp(
    const MockItemsManagerApp(),
  );
}
