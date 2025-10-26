import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/core/enum/task_item_actions.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/core/theme/theme_controller.dart';
import 'package:project1/core/widget/custom_check_box.dart';
import 'package:project1/core/widget/custom_text_form_field.dart';
import 'package:project1/models/task_models.dart';

class TaskListWidgwts extends StatefulWidget {
  const TaskListWidgwts({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
    required this.ondelete,
    required this.onEdit,
  });

  final List<TaskModels> tasks;
  final Function(bool value, int index) onTap;
  final String? emptyMessage;
  final Function(int id) ondelete;
  final Function onEdit;

  @override
  State<TaskListWidgwts> createState() => _TaskListWidgwtsState();
}

class _TaskListWidgwtsState extends State<TaskListWidgwts> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.isEmpty
        ? Center(
            child: Text(
              widget.emptyMessage ?? "No Data",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.tasks.length,
            padding: EdgeInsets.only(bottom: 60),
            itemBuilder: (BuildContext context, int index) {
              final task = widget.tasks[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorScheme.of(context).primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: ThemeController.iaDark()
                          ? Colors.transparent
                          : Color(0xffD1DAD6),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      CustomCheckBox(
                        value: task.isDone,
                        onChanged: (value) {
                          widget.onTap(value!, index);
                        },
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.taskName,
                              style: task.isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                            ),
                            if (task.description.trim().isNotEmpty)
                              Text(
                                task.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: task.isDone
                                      ? Color(0xffA0A0A0)
                                      : Color(0xffC6C6C6),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      PopupMenuButton<TaskItemActions>(
                        onSelected: (value) async {
                          switch (value) {
                            case TaskItemActions.markAsDone:
                              bool newValue = !task.isDone;
                              widget.onTap(newValue, index);
                              break;
                            case TaskItemActions.delete:
                              _showDeleteDialog(context, task.id);
                              break;
                            case TaskItemActions.edit:
                              final result = await _showEditTaskBottomSheet(
                                context,
                                index,
                                widget.tasks,
                              );
                              if (result == true) widget.onEdit();
                              break;
                          }
                        },
                        itemBuilder: (context) => TaskItemActions.values
                            .map(
                              (e) =>
                                  PopupMenuItem(value: e, child: Text(e.name)),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                widget.ondelete(id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showEditTaskBottomSheet(
    BuildContext context,
    int index,
    List<TaskModels> tasks,
  ) async {
    final task = tasks[index];
    final taskNameController = TextEditingController(text: task.taskName);
    final taskDescriptionController = TextEditingController(
      text: task.description,
    );
    bool isHighPriority = task.isHighpriority;
    final _key = GlobalKey<FormState>();

    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 12,
          ),
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 8),
                Text(
                  'Edit Task',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  title: 'Task Name',
                  controller: taskNameController,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty)
                      return 'Please Enter the Task Name';
                    return null;
                  },
                ),
                SizedBox(height: 8),
                CustomTextFormField(
                  maxLines: 5,
                  title: 'Task Description',
                  controller: taskDescriptionController,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('High Priority'),
                    StatefulBuilder(
                      builder: (context, setModalState) {
                        return Switch(
                          value: isHighPriority,
                          onChanged: (bool value) {
                            setModalState(() {
                              isHighPriority = value;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 44),
                  ),
                  onPressed: () async {
                    if (!(_key.currentState?.validate() ?? false)) return;

                    setState(() {
                      tasks[index].taskName = taskNameController.text;
                      tasks[index].description = taskDescriptionController.text;
                      tasks[index].isHighpriority = isHighPriority;
                    });

                    final pref = PreferencesManager();
                    final stored = pref.getString('tasks');
                    List<dynamic> storedList = [];
                    if (stored != null) {
                      try {
                        storedList = jsonDecode(stored) as List<dynamic>;
                      } catch (e) {
                        storedList = [];
                      }
                    }

                    final editedJson = tasks[index].toJson();

                    if (storedList.isEmpty) {
                      storedList = tasks.map((e) => e.toJson()).toList();
                    } else {
                      final idx = storedList.indexWhere((element) {
                        try {
                          return element['id'] == tasks[index].id;
                        } catch (e) {
                          return false;
                        }
                      });
                      if (idx != -1) {
                        storedList[idx] = editedJson;
                      } else {
                        storedList.add(editedJson);
                      }
                    }

                    await pref.setString('tasks', jsonEncode(storedList));

                    Navigator.of(context).pop(true);
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Save'),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
