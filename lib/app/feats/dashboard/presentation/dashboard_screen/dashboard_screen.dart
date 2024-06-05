import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/providers/dashboard_provider.dart';
import 'package:mock_items_manager/app/feats/dashboard/presentation/dashboard_screen/widgets/task_card.dart';
import 'package:mock_items_manager/common/widgets/base_screen.dart';
import 'package:mock_items_manager/utils/router/router.dart';
import 'package:provider/provider.dart';

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
                visible: true,
                // visible: taskProvider.isLoading,
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
            ],
          );
        },
      ),
    );
  }
}
