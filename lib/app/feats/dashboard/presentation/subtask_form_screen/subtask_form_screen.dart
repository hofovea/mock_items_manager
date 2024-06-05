import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/providers/dashboard_provider.dart';
import 'package:mock_items_manager/common/widgets/base_screen.dart';
import 'package:mock_items_manager/utils/router/router.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SubtaskFormScreen extends StatefulWidget {
  final int? taskIndex;
  final int? subtaskIndex;
  final Task? subtask;

  const SubtaskFormScreen({super.key, this.taskIndex, this.subtaskIndex, this.subtask});

  @override
  State<SubtaskFormScreen> createState() => _SubtaskFormScreenState();
}

class _SubtaskFormScreenState extends State<SubtaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late TaskStatus _status;

  @override
  void initState() {
    super.initState();
    if (widget.subtask != null) {
      _title = widget.subtask!.title;
      _status = widget.subtask!.status;
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
        title: Text(widget.subtask == null ? 'Add Subtask' : 'Edit SubTask'),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final subtask = Task.asSubtask(title: _title, status: _status);
                  if (widget.subtask == null) {
                    Provider.of<DashboardProvider>(context, listen: false)
                        .addSubtask(widget.taskIndex, subtask);
                  } else {
                    Provider.of<DashboardProvider>(context, listen: false)
                        .updateSubtask(widget.taskIndex, widget.subtaskIndex!, subtask);
                  }
                  context.router.popForced();
                }
              },
              child: Text(widget.subtask == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
