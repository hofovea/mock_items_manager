// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/auth/domain/providers/auth_provider.dart';
import 'package:mock_items_manager/app/feats/auth/domain/repository/i_auth_repository.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:mock_items_manager/utils/di/service_locator.dart';
import 'package:mock_items_manager/utils/router/router.dart';
import 'feats/dashboard/domain/providers/dashboard_provider.dart';

class MockItemsManagerApp extends StatelessWidget {
  const MockItemsManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardProvider(
            dashboardRepository: serviceLocator.get<IDashboardRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authRepository: serviceLocator.get<IAuthRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
      ),
    );
  }
}
