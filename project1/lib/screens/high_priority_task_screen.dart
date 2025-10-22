import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/models/task_models.dart';
import 'package:project1/widgets/task_list_widgets.dart';

class HighPriorityTaskScreen extends StatefulWidget {
  const HighPriorityTaskScreen({super.key});

  @override
  State<HighPriorityTaskScreen> createState() => _HighPriorityTaskScreenState();
}

class _HighPriorityTaskScreenState extends State<HighPriorityTaskScreen> {
  List<TaskModels> HighPriorityTasks = [];
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
        HighPriorityTasks = taskafterdecode
            .map((element) {
              return TaskModels.fromJson(element);
            })
            .where((tasks) => tasks.isHighpriority)
            .toList();
        // _calculatepercent();
      });
    }
  }

  _deletetask(int id) {
    if (id == null) return;
    setState(() {
      HighPriorityTasks.removeWhere((tasks) => tasks.id == id);
    });
    final updatedTask = HighPriorityTasks.map(
      (element) => element.toJson(),
    ).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    final visibleTasks = HighPriorityTasks.where(
      (task) => task.isHighpriority,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("High Priority Tasks"),
      ),
      body: Container(
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
            final origIndex = HighPriorityTasks.indexWhere(
              (t) => t.id == clickedTask.id,
            );
            if (origIndex != -1) {
              HighPriorityTasks[origIndex] = clickedTask;
            }

            // 4) خزن القائمة كاملة (كمصفوفة من خرائط JSON)
            final pref = PreferencesManager();
            final encoded = jsonEncode(
              HighPriorityTasks.map((e) => e.toJson()).toList(),
            );
            await pref.setString('tasks', encoded);

            // 5) (اختياري) لو عايز تعيد تحميل من التخزين:
            // _loadTask();
            // لكن بما إننا حدّثنا todoTasks محلياً، مش ضروري تعيد التحميل.
          },
        ),
      ),
    );
  }
}
