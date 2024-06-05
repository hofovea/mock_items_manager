// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/providers/dashboard_provider.dart';
import 'package:mock_items_manager/common/widgets/base_screen.dart';
import 'package:mock_items_manager/utils/router/router.dart';

@RoutePage()
class TaskFormScreen extends StatefulWidget {
  final Task? task;
  final int? index;

  const TaskFormScreen({super.key, this.task, this.index});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late TaskStatus _status;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _status = widget.task!.status;
    } else {
      _title = '';
      _status = TaskStatus.todo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.router.push(
                SubtaskFormRoute(taskIndex: widget.index),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            DropdownButtonFormField<TaskStatus>(
              value: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: TaskStatus.values.map((TaskStatus status) {
                return DropdownMenuItem<TaskStatus>(
                  value: status,
                  child: Text(status.toString().split('.').last),
                );
              }).toList(),
              onChanged: (TaskStatus? newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
            ),
            Flexible(
              child: Consumer<DashboardProvider>(
                builder: (BuildContext context, DashboardProvider taskProvider, Widget? child) {
                  final subtasksSource = taskProvider.subtaskBuffer;
                  if (subtasksSource.isNotEmpty) {
                    return ListView.builder(
                      itemCount: subtasksSource.length,
                      itemBuilder: (context, subtaskIndex) {
                        final subtask = subtasksSource[subtaskIndex];
                        return ListTile(
                          title: Text(subtask.title),
                          subtitle: Text(subtask.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  context.router.push(
                                    SubtaskFormRoute(
                                      taskIndex: widget.index,
                                      subtaskIndex: subtaskIndex,
                                      subtask: subtask,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  Provider.of<DashboardProvider>(
                                    context,
                                    listen: false,
                                  ).deleteSubtask(widget.index, subtaskIndex);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final taskProvider = Provider.of<DashboardProvider>(context, listen: false);
                  final task = Task(title: _title, status: _status);
                  if (widget.task == null) {
                    taskProvider.addTask(task);
                  } else {
                    taskProvider.updateTask(widget.index!, task);
                  }
                  context.router.popForced();
                }
              },
              child: Text(widget.task == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
