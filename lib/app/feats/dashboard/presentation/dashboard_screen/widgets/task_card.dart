import 'package:flutter/material.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';

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
                TaskStatus.inProgress =>
                  const Icon(Icons.run_circle, color: Colors.deepOrange),
                TaskStatus.done => const Icon(Icons.check_circle, color: Colors.green),
              },
            ),
            if (task.subtasks != null) ...[
              ...[
                task.subtasks!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              task.subtasks!.map((subtask) => TaskCard(task: subtask)).toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
