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

  @override
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
                        value: widget.tasks[index].isDone ?? false,
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
                              widget.tasks[index].taskName,
                              style: widget.tasks[index].isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,

                              maxLines: 1,
                            ),

                            if ((widget.tasks[index].description
                                .trim()
                                .isNotEmpty))
                              Text(
                                widget.tasks[index].description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: widget.tasks[index].isDone
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
                              bool newValue = !(widget.tasks[index].isDone);
                              widget.onTap(newValue, index);

                              break;
                            case TaskItemActions.delete:
                              // print(value.name);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Delete Task"),
                                    content: Text(
                                      "Are You sure you want to delete task?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          widget.ondelete(
                                            widget.tasks[index].id,
                                          );
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                        child: Text("Delete"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              );
                              break;
                            case TaskItemActions.edit:
                              print(value.name);
                              final result = await _showEditTaskBottomSheet(
                                context,
                                index,
                                widget.tasks,
                              );
                              if (result == true) {
                                widget.onEdit();
                              }
                              break;
                          }
                        },

                        itemBuilder: (context) => TaskItemActions.values.map((
                          e,
                        ) {
                          return PopupMenuItem(value: e, child: Text(e.name));
                        }).toList(),
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

  Future<bool?> _showEditTaskBottomSheet(
    BuildContext context,
    int index,
    List<TaskModels> tasks,
  ) {
    final task = tasks[index];
    final taskNameController = TextEditingController(text: task.taskName);
    final taskDescriptionController = TextEditingController(
      text: task.description,
    );
    bool isHighPriority = task.isHighpriority ?? false;
    final _key = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        title: "Task Name",
                        controller: taskNameController,
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty ?? false) {
                            return "Please Enter the Task Name";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        maxLines: 5,
                        title: "Task Description",
                        controller: taskDescriptionController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("High Priority "),

                          StatefulBuilder(
                            builder: (context, setModalState) {
                              return Switch(
                                value: isHighPriority,
                                onChanged: (bool value) {
                                  setModalState(() {
                                    isHighPriority = value;
                                    print(value);
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      //  Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              tasks[index].taskName = taskNameController.text;
                              tasks[index].description =
                                  taskDescriptionController.text;
                              tasks[index].isHighpriority = isHighPriority;
                            });

                            // 2️⃣ رجّع اللستة كلها كـ JSON واحفظها
                            final updatedTasksJson = jsonEncode(
                              tasks.map((e) => e.toJson()).toList(),
                            );
                            await PreferencesManager().setString(
                              "tasks",
                              updatedTasksJson,
                            );

                            // 3️⃣ اقفل الـ BottomSheet
                            Navigator.of(context).pop(true);
                          }
                        },
                        icon: Icon(Icons.edit),
                        label: Text("Edit Task"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
