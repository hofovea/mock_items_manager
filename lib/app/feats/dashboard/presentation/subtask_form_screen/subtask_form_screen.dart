// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/subtask/subtask.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/providers/dashboard_provider.dart';
import 'package:mock_items_manager/common/widgets/base_screen.dart';

@RoutePage()
class SubtaskFormScreen extends StatefulWidget {
  final int? taskIndex;
  final int? subtaskIndex;
  final Subtask? subtask;

  const SubtaskFormScreen({super.key, this.taskIndex, this.subtaskIndex, this.subtask});

  @override
  State<SubtaskFormScreen> createState() => _SubtaskFormScreenState();
}

class _SubtaskFormScreenState extends State<SubtaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    if (widget.subtask != null) {
      _title = widget.subtask!.title;
      _description = widget.subtask!.description;
    } else {
      _title = '';
      _description = '';
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
            TextFormField(
              initialValue: _description,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final subtask = Subtask(title: _title, description: _description);
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
