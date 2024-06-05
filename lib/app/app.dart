import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mock_items_manager/app/feats/auth/domain/providers/auth_provider.dart';
import 'package:mock_items_manager/app/feats/auth/domain/repository/i_auth_repository.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';

import 'package:mock_items_manager/utils/router/router.dart';
import 'package:provider/provider.dart';

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
            dashboardRepository: GetIt.I.get<IDashboardRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authRepository: GetIt.I.get<IAuthRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
      ),
    );
  }
}
