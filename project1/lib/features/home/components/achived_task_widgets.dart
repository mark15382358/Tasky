import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project1/core/theme/theme_controller.dart';

class AchivedTaskWidgets extends StatefulWidget {
  const AchivedTaskWidgets({
    super.key,
    required this.totalDoneTasks,
    required this.totalTasks,
    required this.percent,
  });
  final int totalDoneTasks;
  final int totalTasks;
  final double percent;
  @override
  State<AchivedTaskWidgets> createState() => _AchivedTaskWidgetsState();
}

class _AchivedTaskWidgetsState extends State<AchivedTaskWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.iaDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4),
              Text(
                "${widget.totalDoneTasks} Out of ${widget.totalTasks} Done",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 48,
                width: 48,
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: CircularProgressIndicator(
                    value: widget.percent,
                    backgroundColor: Color(0xFF6D6D6D),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xff15B86C),
                    ),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                "${((widget.percent * 100).toInt())}%",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
