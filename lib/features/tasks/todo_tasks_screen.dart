import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class TodoTasksScreen extends StatelessWidget {
  const TodoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(AppSizes.pw18),
              child: Text(
                'To Do Tasks',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.pw16),
                child: controller.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Consumer<TasksController>(
                        builder: (BuildContext context, value, Widget? child) {
                          return TaskListWidget(
                            tasks: value.todoTasks,
                            onTap: (value, index) async {
                              controller.doneTask(value, index);
                            },
                            emptyMessage: 'No Task Found',
                            onDelete: (int? id) {
                              controller.deleteTask(id);
                            },
                            onEdit: () {
                              controller.init();
                            },
                          );
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
