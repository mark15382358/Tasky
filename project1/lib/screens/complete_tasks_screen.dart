import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/models/task_models.dart';
import 'package:project1/widgets/task_list_widgets.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModels> tasksDone = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _deletetask(int id) {
    if (id == null) return;
    setState(() {
      tasksDone.removeWhere((tasks) => tasks.id == id);
    });
    final updatedTask = tasksDone.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  Future<void> _loadTasks() async {
    final allData = PreferencesManager().getString('tasks');
    if (allData != null) {
      final taskList = (jsonDecode(allData) as List)
          .map((e) => TaskModels.fromJson(e))
          .toList();
      setState(() {
        tasksDone = taskList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // filtered tasks
    final completedTasks = tasksDone
        .where((task) => !task.isDone == false)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: TaskListWidgwts(
            onEdit: () {
              _loadTasks();
            },
            ondelete: (index) {
              _deletetask(index);
            },
            emptyMessage: "No Task Found",
            tasks: completedTasks,
            onTap: (value, index) async {
              // 1) المهمة اللي اتضغطت عليها (من قائمة العرض)
              final clickedTask = completedTasks[index];

              // 2) حدث الحالة فوراً في الكائن نفسه
              setState(() {
                clickedTask.isDone = value ?? false;
              });

              // 3) حدّد مكان نفس المهمة في القائمة الأساسية (todoTasks)
              final origIndex = tasksDone.indexWhere(
                (t) => t.id == clickedTask.id,
              );
              if (origIndex != -1) {
                tasksDone[origIndex] = clickedTask;
              }

              // 4) خزن القائمة كاملة (كمصفوفة من خرائط JSON)
              final encoded = jsonEncode(
                tasksDone.map((e) => e.toJson()).toList(),
              );
              await PreferencesManager().setString('tasks', encoded);

              // 5) (اختياري) لو عايز تعيد تحميل من التخزين:
              // _loadTask();
              // لكن بما إننا حدّثنا todoTasks محلياً، مش ضروري تعيد التحميل.
            },
          ),
        ),
      ],
    );
  }
}
