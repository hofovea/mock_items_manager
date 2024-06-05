// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/presentation/dashboard_screen/widgets/subtask_card.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(task.title),
              subtitle: Text(task.status.toString().split('.').last),
              trailing: switch (task.status) {
                TaskStatus.todo => const Icon(Icons.circle, color: Colors.grey),
                TaskStatus.inProgress => const Icon(Icons.run_circle, color: Colors.deepOrange),
                TaskStatus.done => const Icon(Icons.check_circle, color: Colors.green),
              },
            ),
            ...[
              task.subtasks.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            task.subtasks.map((subtask) => SubtaskCard(subtask: subtask)).toList(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ],
        ),
      ),
    );
  }
}
