import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];

  init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      todoTasks = tasks.where((element) => !element.isDone).toList();
      completeTasks = tasks.where((element) => element.isDone).toList();
      highPriorityTasks =
          tasks.where((element) => element.isHighPriority).toList();

      highPriorityTasks = highPriorityTasks.reversed.toList();
      // calculatePercent();
    }

    isLoading = false;

    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void doneCompleteTask(bool? value, int? index) async {
    if (index == null) return;
    completeTasks[index].isDone = value ?? false;

    final int newIndex =
        tasks.indexWhere((e) => e.id == completeTasks[index].id);
    tasks[newIndex] = completeTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  void doneHighPriorityTasks(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isDone = value ?? false;

    final int newIndex =
        tasks.indexWhere((e) => e.id == highPriorityTasks[index].id);
    tasks[newIndex] = highPriorityTasks[index];

    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);

    todoTasks.removeWhere((task) => task.id == id);
    tasks.removeWhere((task) => task.id == id);
    completeTasks.removeWhere((task) => task.id == id);
    highPriorityTasks.removeWhere((task) => task.id == id);
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }
}
