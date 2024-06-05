// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/auth/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:mock_items_manager/app/feats/auth/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/subtask/subtask.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:mock_items_manager/app/feats/dashboard/presentation/subtask_form_screen/subtask_form_screen.dart';
import 'package:mock_items_manager/app/feats/dashboard/presentation/task_form_screen/task_form_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInFormRoute.page, initial: true),
        AutoRoute(page: SignUpFormRoute.page),
        AutoRoute(page: DashboardRoute.page),
        AutoRoute(page: TaskFormRoute.page),
        AutoRoute(page: SubtaskFormRoute.page),
      ];
}
