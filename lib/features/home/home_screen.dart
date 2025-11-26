import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/add_task/add_task_controller.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky/features/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.all(AppSizes.h16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Selector<HomeController, String?>(
                          selector: (context, HomeController controller) => controller.userImagePath,
                          builder: (BuildContext context, String? userImagePath, Widget? child) {
                            return CircleAvatar(
                              backgroundImage: userImagePath == null
                                  ? AssetImage('assets/images/person.png')
                                  : FileImage(File(userImagePath)),
                            );
                          },
                        ),
                        SizedBox(width: AppSizes.w8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              selector: (context, HomeController controller) => controller.username,
                              builder: (BuildContext context, String? username, Widget? child) {
                                return Text(
                                  "Good Evening, $username",
                                  style: Theme.of(context).textTheme.titleMedium,
                                );
                              },
                            ),
                            Text(
                              "One task at a time. One step closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    Text(
                      'Yuhuu ,Your work Is',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withoutColor(path: 'assets/images/waving_hand.svg'),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),
                    AchievedTasksWidget(),
                    SizedBox(height: AppSizes.h8),
                    HighPriorityTasksWidget(),
                    Padding(
                      padding:  EdgeInsets.only(top: AppSizes.ph24, bottom: AppSizes.ph16),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              SliverTaskListWidget(),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: AppSizes.h44,
          child: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return  AddTaskScreen();
                      },
                    ),
                  );

                  if (result != null && result) {
                    context.read<HomeController>().loadTask();
                  }
                },
                label: Text(
                  'Add New Task',
                ),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              );
            },
          ),
        ),
      ),
    );
  }
}
