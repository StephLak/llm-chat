import 'package:flutter/material.dart';
import 'package:worklyn_task/constants/app_colors.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.inputColor,
        borderRadius: BorderRadius.circular(99),
      ),
      child: child,
    );
  }
}
