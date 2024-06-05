// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/subtask/subtask.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/entity/task/task.dart';
import 'package:mock_items_manager/app/feats/dashboard/domain/repository/i_dashboard_repository.dart';
import 'package:mock_items_manager/core/failures/failures.dart';

class DashboardProvider with ChangeNotifier {
  final IDashboardRepository _dashboardRepository;
  final List<Task> _tasks = [];
  final List<Subtask> _subtasksBuffer = [];
  String? errorMessage;
  bool isLoading = false;

  DashboardProvider({
    required IDashboardRepository dashboardRepository,
  }) : _dashboardRepository = dashboardRepository {
    loadTasks();
  }

  List<Subtask> get subtaskBuffer => _subtasksBuffer;

  List<Task> get tasks => _tasks;

  void _saveCurrentTaskList() {
    notifyListeners();
    _dashboardRepository.saveChanges(_tasks).then(
      (saveOperation) async {
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

  void loadTasks() async {
    isLoading = true;
    notifyListeners();
    final operationResult = await _dashboardRepository.loadDashboard();
    operationResult.fold(
      (failure) {
        onFailure(failure);
      },
      (loadedTasks) {
        _tasks.clear();
        _tasks.addAll(loadedTasks);
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void presetSubtaskBuffer(List<Subtask> newSubtasks) {
    _subtasksBuffer.clear();
    if (newSubtasks.isNotEmpty) {
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
  void addSubtask(int? taskIndex, Subtask subtask) {
    _subtasksBuffer.add(subtask);
    notifyListeners();
  }

  void updateSubtask(int? taskIndex, int subtaskIndex, Subtask subtask) {
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
      UnknownFailure() => 'Something went wrong',
    };
    notifyListeners();
  }

  void resetFailure() {
    errorMessage = null;
    notifyListeners();
  }
}
