import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/core/widget/custom_text_form_field.dart';
import 'package:project1/models/task_models.dart';
import 'package:project1/screens/home_screen.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController taskNameController = TextEditingController();

  TextEditingController taskDescriptionController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isHighpriority = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(title: Text("New Task")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: taskNameController,
                          hintText: "Finish UI design for login screen",
                          title: "Task Name",
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty ??
                                false) {
                              return "Please Enter the Task Name";
                            }
                          },
                        ),
                        SizedBox(height: 20),

                        CustomTextFormField(
                          controller: taskDescriptionController,
                          maxLines: 5,
                          title: "Task Description",
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Priority ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffFFFCFC),
                              ),
                            ),

                            Switch(
                              value: isHighpriority,
                              onChanged: (bool value) {
                                setState(() {
                                  isHighpriority = value;
                                  print(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final taskJson = PreferencesManager().getString("tasks");
                      List<dynamic> listTasks = [];
                      if (taskJson != null) {
                        listTasks = jsonDecode(taskJson);
                      }
                      TaskModels models = TaskModels(
                        id: listTasks.length + 1,
                        taskName: taskNameController.text,
                        description: taskDescriptionController.text,
                        isHighpriority: isHighpriority,
                      );

                      listTasks.add(models.toJson());
                      final taskEncode = jsonEncode(listTasks);
                      await PreferencesManager().setString("tasks", taskEncode);
                      Navigator.of(context).pop(true);
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
