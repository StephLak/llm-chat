import 'package:flutter/material.dart';
import 'package:worklyn_task/constants/app_colors.dart';

class TaskDot extends StatelessWidget {
  const TaskDot({
    super.key,
    this.color = AppColors.hintColor,
    this.hasLeftPadding = true,
  });

  final Color color;
  final bool hasLeftPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      margin: EdgeInsets.only(right: 10, left: hasLeftPadding ? 10 : 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: color),
      ),
    );
  }
}
