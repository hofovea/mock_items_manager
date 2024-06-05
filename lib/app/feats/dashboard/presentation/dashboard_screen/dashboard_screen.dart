// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/providers/dashboard_provider.dart';
import 'package:mock_items_manager/app/feats/dashboard/presentation/dashboard_screen/widgets/task_card.dart';
import 'package:mock_items_manager/common/widgets/base_screen.dart';
import 'package:mock_items_manager/utils/router/router.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(
                TaskFormRoute(),
              );
            },
          ),
        ],
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, taskProvider, child) {
          return Stack(
            children: [
              ReorderableListView(
                onReorder: taskProvider.reorderTasks,
                children: List.generate(
                  taskProvider.tasks.length,
                  (index) {
                    final task = taskProvider.tasks[index];
                    return ListTile(
                      key: ValueKey(task),
                      title: TaskCard(task: task),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Provider.of<DashboardProvider>(context, listen: false)
                                  .presetSubtaskBuffer(
                                task.subtasks,
                              );
                              context.router.push(
                                TaskFormRoute(task: task, index: index),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              taskProvider.deleteTask(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: taskProvider.isLoading,
                child: Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(strokeWidth: 5),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: taskProvider.errorMessage != null,
                child: Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.cancel_outlined, size: 125),
                            const SizedBox(height: 15),
                            Flexible(
                              child: Text(
                                textAlign: TextAlign.center,
                                taskProvider.errorMessage ?? '',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  taskProvider.resetFailure();
                                  taskProvider.loadTasks();
                                },
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Try again',
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
