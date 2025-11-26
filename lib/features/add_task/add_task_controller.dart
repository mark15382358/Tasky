
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController = TextEditingController();

  bool isHighPriority = true;

  void addTask(BuildContext context) async{
    if (key.currentState?.validate() ?? false) {
      final taskJson = PreferencesManager().getString(StorageKey.tasks);

      List<dynamic> listTasks = [];

      if (taskJson != null) {
        listTasks = jsonDecode(taskJson);
      }

      // listTasks.length = 1 -> 1 + 1
      TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      listTasks.add(model.toJson());

      final taskEncode = jsonEncode(listTasks);
      await PreferencesManager().setString(StorageKey.tasks, taskEncode);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
