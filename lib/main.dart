import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_constants.dart';
import 'package:worklyn_task/core/home/view/home_screen.dart';
import 'package:worklyn_task/internalization/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final orientations = <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ];
    SystemChrome.setPreferredOrientations(orientations);
    return GetMaterialApp(
      title: AppConstants.appName,
      locale: AppConstants.engLocale,
      supportedLocales: const <Locale>[AppConstants.engLocale],
      fallbackLocale: AppConstants.engLocale,
      translations: AppStrings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      home: const HomeScreen(),
    );
  }
}
