// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/subtask/subtask.dart';

class SubtaskCard extends StatelessWidget {
  final Subtask subtask;

  const SubtaskCard({super.key, required this.subtask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subtask.title),
      subtitle: Text(subtask.description),
    );
  }
}
