import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});
  @override 
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext _) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Completed Tasks',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        value: 20,
                      ))
                    : Consumer<TasksController>(
                        builder: (BuildContext context, value, Widget? child) {
                          return TaskListWidget(
                            tasks: value.completeTasks,
                            onTap: (value, index) async {
                              controller.doneCompleteTask(value, index);
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