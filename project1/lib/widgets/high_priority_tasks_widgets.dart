import 'package:flutter/material.dart';
import 'package:project1/core/theme/theme_controller.dart';
import 'package:project1/core/widget/custom_check_box.dart';
import 'package:project1/models/task_models.dart';
import 'package:project1/screens/high_priority_task_screen.dart';
import 'package:project1/widgets/custom_svg_picture_widget.dart';

class Highprioritytaskswidgets extends StatelessWidget {
  Highprioritytaskswidgets({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });
  final List<TaskModels> tasks;
  final Function(bool value, int index) onTap;
  Function refresh;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),

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
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "High Priority Tasks",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff15B86C),
                  ),
                ),
                ...tasks.reversed.where((e) => e.isHighpriority).take(4).map((
                  element,
                ) {
                  return Row(
                    children: [
                      CustomCheckBox(
                        value: element.isDone ?? false,
                        onChanged: (value) {
                          final index = tasks.indexWhere((e) {
                            return e.id == element.id;
                          });
                          onTap(value!, index);
                        },
                      ),

                      Flexible(
                        child: Text(
                          element.taskName,
                          style: element.isDone
                              ? Theme.of(context).textTheme.titleLarge
                              : Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (buildcontext) => HighPriorityTaskScreen(),
                ),
              );
              refresh();
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(16),
                height: 56,
                width: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    
                    color:ThemeController.iaDark()?
                     Color(0xff6E6E6E):Color(0xffD1DAD6)),
                ),
                child:CustomSvgPictureWidget(path: "assets/images/rightarrow.svg",withColorFilter: true,)
          
              ),
            ),
          ),
        ],
      ),
    );
  }
}
