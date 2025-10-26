import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/models/task_models.dart';
import 'package:project1/core/components/task_list_widgets.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModels> todoTasks = [];
  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final taskencoded = PreferencesManager().getString("tasks");
    if (taskencoded != null) {
      final taskafterdecode = jsonDecode(taskencoded) as List<dynamic>;
      setState(() {
        todoTasks = taskafterdecode
            .map((element) => TaskModels.fromJson(element))
            .toList();
      });
    }
  }

  _deletetask(int id) {
    if (id == null) return;
    setState(() {
      todoTasks.removeWhere((tasks) => tasks.id == id);
    });
    final updatedTask = todoTasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    final visibleTasks = todoTasks.where((task) => !task.isDone).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: TaskListWidgwts(
            onEdit: () {
              _loadTask();
            },
            ondelete: (index) {
              _deletetask(index);
            },
            emptyMessage: "No Task Found",
            tasks: visibleTasks,
            onTap: (value, index) async {
              // 1) المهمة اللي اتضغطت عليها (من قائمة العرض)
              final clickedTask = visibleTasks[index];

              // 2) حدث الحالة فوراً في الكائن نفسه
              setState(() {
                clickedTask.isDone = value ?? false;
              });

              // 3) حدّد مكان نفس المهمة في القائمة الأساسية (todoTasks)
              final origIndex = todoTasks.indexWhere(
                (t) => t.id == clickedTask.id,
              );
              if (origIndex != -1) {
                todoTasks[origIndex] = clickedTask;
              }

              // 4) خزن القائمة كاملة (كمصفوفة من خرائط JSON)
              final encoded = jsonEncode(
                todoTasks.map((e) => e.toJson()).toList(),
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
