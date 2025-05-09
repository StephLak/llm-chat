import 'package:flutter/material.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_constants.dart';

class AppInputBorders {
  static const focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppConstants.inputRadius)),
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppConstants.inputRadius)),
    borderSide: BorderSide(color: Colors.transparent),
  );
}
