import 'package:flutter/material.dart';
import 'package:worklyn_task/constants/app_colors.dart';

class AppTextStyles {
  static const Color defaultColor = AppColors.textColor;

  // static TextStyle thinTextStyle({
  //   Color color = defaultColor,
  //   double size = 14,
  //   TextDecoration decoration = TextDecoration.none,
  //   FontStyle fontStyle = FontStyle.normal,
  // }) {
  //   return TextStyle(
  //     fontSize: size,
  //     fontWeight: FontWeight.w100,
  //     color: color,
  //     letterSpacing: -0.5,
  //     decoration: decoration,
  //     fontStyle: fontStyle,
  //   );
  // }

  // static TextStyle lightTextStyle({
  //   Color color = defaultColor,
  //   double size = 14,
  //   TextDecoration decoration = TextDecoration.none,
  //   bool italic = false,
  // }) {
  //   return TextStyle(
  //     fontSize: size,
  //     fontWeight: FontWeight.w300,
  //     color: color,
  //     decoration: decoration,
  //     letterSpacing: -0.5,
  //     fontStyle: italic ? FontStyle.italic : FontStyle.normal,
  //   );
  // }

  static TextStyle regularTextStyle({
    Color color = defaultColor,
    double size = 14,
    Color decorationColor = defaultColor,
  }) {
    return TextStyle(fontSize: size, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle mediumTextStyle({
    Color color = defaultColor,
    double size = 14,
  }) {
    return TextStyle(fontSize: size, fontWeight: FontWeight.w500, color: color);
  }

  // static TextStyle semiBoldTextStyle({
  //   Color color = defaultColor,
  //   double size = 16,
  //   FontStyle fontStyle = FontStyle.normal,
  //   TextDecoration decoration = TextDecoration.none,
  //   TextDecorationStyle decorationStyle = TextDecorationStyle.solid,
  //   Color decorationColor = defaultColor,
  //   double decorationThickness = 1.0,
  // }) {
  //   return TextStyle(
  //     fontSize: size,
  //     fontWeight: FontWeight.w600,
  //     color: color,
  //     fontStyle: fontStyle,
  //     letterSpacing: -0.5,
  //     decoration: decoration,
  //     decorationColor: decorationColor,
  //     decorationStyle: decorationStyle,
  //     decorationThickness: decorationThickness,
  //   );
  // }

  static TextStyle boldTextStyle({
    Color color = defaultColor,
    double size = 16,
  }) {
    return TextStyle(fontSize: size, fontWeight: FontWeight.w700, color: color);
  }

  // static TextStyle extraBoldTextStyle({
  //   Color color = defaultColor,
  //   double size = 16,
  //   TextDecoration decoration = TextDecoration.none,
  //   FontStyle fontStyle = FontStyle.normal,
  // }) {
  //   return TextStyle(
  //     fontSize: size,
  //     decoration: decoration,
  //     fontWeight: FontWeight.w800,
  //     color: color,
  //     letterSpacing: -0.5,
  //     fontStyle: fontStyle,
  //   );
  // }

  // static TextStyle linkTextStyle({
  //   double size = 16,
  //   Color color = defaultColor,
  // }) {
  //   return TextStyle(
  //     fontSize: size,
  //     fontWeight: FontWeight.w600,
  //     color: Colors.transparent,
  //     height: 1.1,
  //     shadows: [Shadow(color: color, offset: Offset(0, -2))],
  //     letterSpacing: -0.5,
  //     decoration: TextDecoration.underline,
  //     decorationColor: color,
  //   );
  // }
}
