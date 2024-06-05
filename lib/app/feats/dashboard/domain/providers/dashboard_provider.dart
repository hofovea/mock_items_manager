import 'package:flutter/material.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:mock_items_manager/core/failures/failures.dart';

class DashboardProvider with ChangeNotifier {
  final IDashboardRepository _dashboardRepository;
  final List<Task> _tasks = [];
  final List<Task> _subtasksBuffer = [];
  String? errorMessage;
  bool isLoading = false;

  DashboardProvider({
    required IDashboardRepository dashboardRepository,
  }) : _dashboardRepository = dashboardRepository;

  List<Task> get subtaskBuffer => _subtasksBuffer;

  List<Task> get tasks => _tasks;

  void _saveCurrentTaskList() {
    isLoading = true;
    notifyListeners();
    _dashboardRepository.saveChanges(_tasks).then(
      (saveOperation) {
        saveOperation.fold(
          (failure) {
            onFailure(failure);
          },
          (_) {
            isLoading = false;
            notifyListeners();
          },
        );
      },
    );
  }

  void presetSubtaskBuffer(List<Task>? newSubtasks) {
    _subtasksBuffer.clear();
    if (newSubtasks != null && newSubtasks.isNotEmpty) {
      _subtasksBuffer.addAll(newSubtasks);
    }
  }

  void addTask(Task task) async {
    final taskWithBuffer = task.copyWith(
      subtasks: _subtasksBuffer.isNotEmpty ? [..._subtasksBuffer] : [],
    );
    _tasks.add(taskWithBuffer);
    _subtasksBuffer.clear();
    _saveCurrentTaskList();
  }

  void updateTask(int index, Task task) {
    final taskWithBuffer = task.copyWith(
      subtasks: _subtasksBuffer.isNotEmpty ? [..._subtasksBuffer] : [],
    );
    _tasks[index] = taskWithBuffer;
    _subtasksBuffer.clear();
    _saveCurrentTaskList();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    _saveCurrentTaskList();
  }

  void reorderTasks(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final Task task = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, task);
    _saveCurrentTaskList();
  }

  //Subtasks operations
  void addSubtask(int? taskIndex, Task subtask) {
    _subtasksBuffer.add(subtask);
    notifyListeners();
  }

  void updateSubtask(int? taskIndex, int subtaskIndex, Task subtask) {
    _subtasksBuffer[subtaskIndex] = subtask;
    notifyListeners();
  }

  void deleteSubtask(int? taskIndex, int subtaskIndex) {
    _subtasksBuffer.removeAt(subtaskIndex);
    notifyListeners();
  }

  void onFailure(Failure failure) {
    errorMessage = switch (failure) {
      ServerInternalFailure() => 'Server could not process request',
      ServerUnavailableFailure() => 'Server currently not available, try later',
      InvalidResponseFailure() => 'Invalid response, try again',
      UserMissingFailure() => 'User not found, try creating account',
      UserAlreadyExistsFailure() => 'This user already exists',
    };
    notifyListeners();
  }

  void resetFailure() {
    errorMessage = null;
    notifyListeners();
  }
}
