import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final Controller = context.read<TasksController>();
        return Scaffold(
          appBar: AppBar(
            title: Text('High Priority Tasks'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Consumer<TasksController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return TaskListWidget(
                        tasks: value.highPriorityTasks,
                        onTap: (value, index) async {
                          Controller.doneHighPriorityTasks(value, index);
                          // setState(() {
                          //   highPriorityTasks[index!].isDone = value ?? false;
                          // });

                          // final allData =
                          //     PreferencesManager().getString(StorageKey.tasks);

                          // if (allData != null) {
                          //   List<TaskModel> allDataList = (jsonDecode(allData)
                          //           as List)
                          //       .map((element) => TaskModel.fromJson(element))
                          //       .toList();

                          //   final int newIndex = allDataList.indexWhere(
                          //       (e) => e.id == highPriorityTasks[index!].id);
                          //   allDataList[newIndex] = highPriorityTasks[index!];

                          //   await PreferencesManager().setString(
                          //       StorageKey.tasks, jsonEncode(allDataList));
                          //   _loadTask();
                          // }
                        },
                        emptyMessage: 'No Task Found',
                        onDelete: (int? id) {
                          Controller.deleteTask(id);
                        },
                        onEdit: () {
                          Controller.init();
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
