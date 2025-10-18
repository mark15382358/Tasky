import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/core/theme/theme_controller.dart';
import 'package:project1/core/widget/custom_check_box.dart';
import 'package:project1/models/task_models.dart';

class TaskListWidgwts extends StatelessWidget {
  const TaskListWidgwts({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
  });

  @override
  final List<TaskModels> tasks;
  final Function(bool value, int index) onTap;
  final String? emptyMessage;
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessage ?? "No Data",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            itemCount: tasks.length,
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
                        value: tasks[index].isDone ?? false,
                        onChanged: (value) {
                          onTap(value!, index);
                        },
                      ),

                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[index].taskName,
                              style: tasks[index].isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,

                              maxLines: 1,
                            ),

                            if ((tasks[index].description.trim().isNotEmpty))
                              Text(
                                tasks[index].description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: tasks[index].isDone
                                      ? Color(0xffA0A0A0)
                                      : Color(0xffC6C6C6),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == "Delete") {
                            print(value);
                          } else if (value == "Edit") {
                            print(value);
                          }
                        },
                        icon: Icon(
                          Icons.more_vert,
                          color: ThemeController.iaDark()
                              ? (tasks[index].isDone
                                    ? Color(0xffC6C6C6)
                                    : Color(0xffA0A0A0))
                              : (tasks[index].isDone
                                    ? Color(0xff6A6A6A)
                                    : Color(0xff3A4640)),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "Edit",
                            child: Text("Edit"),
                          ),
                          PopupMenuItem(
                            value: "Delete",
                            child: Text(
                              "Delete",
                            ),
                          ),
                        ],
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
}
