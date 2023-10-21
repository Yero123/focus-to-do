import 'package:flutter/material.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class TaskCheckBox extends StatelessWidget {
  final TaskPriority priority;
  const TaskCheckBox({
    Key? key,
    this.priority = TaskPriority.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.nonePriorityColorLight;
    Color borderColor = AppColors.nonePriorityColor;
    if (priority == TaskPriority.low) {
      color = AppColors.lowPriorityColorLight;
      borderColor = AppColors.lowPriorityColor;
    }
    if (priority == TaskPriority.medium) {
      color = AppColors.mediumPriorityColorLight;
      borderColor = AppColors.mediumPriorityColor;
    }
    if (priority == TaskPriority.high) {
      color = AppColors.highPriorityColorLight;
      borderColor = AppColors.highPriorityColor;
    }

    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: borderColor,
          width: 2.5,
        ),
      ),
    );
  }
}