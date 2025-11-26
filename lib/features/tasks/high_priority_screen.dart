import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
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
            padding:  EdgeInsets.all(AppSizes.pw16),
            child: Controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Consumer<TasksController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return TaskListWidget(
                        tasks: value.highPriorityTasks,
                        onTap: (value, index) async {
                          Controller.doneHighPriorityTasks(value, index);
                     
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
