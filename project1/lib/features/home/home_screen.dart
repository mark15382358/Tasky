import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/models/task_models.dart';
import 'package:project1/features/add_tasks/add_task_screen.dart' hide TaskModels;
import 'package:project1/features/home/components/achived_task_widgets.dart';
import 'package:project1/widgets/custom_svg_picture_widget.dart';
import 'package:project1/features/home/components/high_priority_tasks_widgets.dart';
import 'package:project1/core/components/task_list_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  // List<dynamic> task = [];
  List<TaskModels> tasks = [];
  int totalDoneTasks = 0;
  int totalTasks = 0;
  double percent = 0;
  String?  ImagePath;
  @override
  void initState() {
    super.initState();
    _loadusername();
    _loadTask();
    _loadImage();
  }

  _doneTasks(value, index) async {
    setState(() {
      tasks[index].isDone = value!;
      totalDoneTasks = tasks.where((task) => task.isDone == true).length;
      _calculatepercent();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  _deletetask(int id) {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((tasks) => tasks.id == id);
      _calculatepercent();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  void _loadTask() async {
    final taskencoded = PreferencesManager().getString("tasks");
    if (taskencoded != null) {
      final taskafterdecode = jsonDecode(taskencoded) as List<dynamic>;
      setState(() {
        tasks = taskafterdecode.map((element) {
          return TaskModels.fromJson(element);
        }).toList();
        _calculatepercent();
      });
    }
  }

  void _calculatepercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((task) => task.isDone == true).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    print("percent   $percent");
  }

  void _loadusername() async {
    setState(() {
      username = PreferencesManager().getString("username");
    });
  }
  
 void _loadImage() {
  final path = PreferencesManager().getString("user_image");
  if (path != null && File(path).existsSync()) {
    setState(() {
      ImagePath = path;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    print("home screeeeen");
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () async {
            bool result =
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTaskScreen()),
                ) ??
                false;

            if (result) {
              _loadTask();
            }
          },
          label: Text("Add New Task"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                      
                        backgroundImage: ImagePath==null? AssetImage("assets/images/6.png"):
                        FileImage(File(ImagePath!))as ImageProvider
                        ,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Evening , $username",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "One task at a time.One step closer. ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Text(
                    "Yuhuu ,Your work Is ",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 16),
                      Text(
                        "almost done ! ",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      CustomSvgPictureWidget(
                        path: "assets/images/3.svg",
                        withColorFilter: false,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchivedTaskWidgets(
                    totalDoneTasks: totalDoneTasks,
                    totalTasks: totalTasks,
                    percent: percent,
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Highprioritytaskswidgets(
                    tasks: tasks,

                    onTap: (value, index) {
                      _doneTasks(value, index);
                    },
                    refresh: () {
                      _loadTask();
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 16, left: 16),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "My Tasks",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  TaskListWidgwts(
                    onEdit: () {
                      _loadTask();
                    },
                    ondelete: (id) {
                      _deletetask(id);
                    },
                    tasks: tasks,
                    onTap: (value, index) {
                      _doneTasks(value, index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
