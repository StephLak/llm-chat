import 'package:flutter/material.dart';
import 'package:worklyn_task/constants/app_constants.dart';

class AppInputBorders {
  static const border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppConstants.inputRadius)),
    borderSide: BorderSide(color: Colors.transparent),
  );
}
