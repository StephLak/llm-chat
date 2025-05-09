import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_constants.dart';
import 'package:worklyn_task/constants/app_text_styles.dart';
import 'package:worklyn_task/internalization/app_strings.dart';

double queryHeight(BuildContext? context) {
  return context != null ? MediaQuery.of(context).size.height : Get.size.height;
}

double queryWidth(BuildContext? context) {
  return context != null ? MediaQuery.of(context).size.width : Get.size.width;
}

void showSnackbarMessage({required String message, bool isSuccess = false}) {
  final snackbar = GetSnackBar(
    titleText: Text(
      isSuccess ? AppStrings.success.tr : AppStrings.error.tr,
      style: AppTextStyles.mediumTextStyle(color: AppColors.white, size: 18),
    ),
    messageText: Text(
      message,
      style: AppTextStyles.regularTextStyle(color: AppColors.white, size: 14),
    ),
    backgroundColor: isSuccess ? Colors.green.shade900 : Colors.red.shade900,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    borderRadius: AppConstants.inputRadius,
  );

  Get.showSnackbar(snackbar);
}

void showAppBottomSheet({required Widget child}) {
  Get.bottomSheet(
    DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9, // Covers 90% of the screen
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: AppColors.bottomSheetColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: ListView(controller: scrollController, children: [child]),
        );
      },
    ),
    isScrollControlled: true, // Important for full-height bottom sheets
  );
}

String dateFormat(DateTime date) {
  const List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  const List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String weekday = weekdays[date.weekday - 1];
  String day = date.day.toString().padLeft(2, '0');
  String month = months[date.month - 1];

  return '$weekday, $day $month';
}

String formatDate(dynamic date, {bool isSheet = false}) {
  if (date == '' || date == null) {
    return AppStrings.noDate.tr;
  } else {
    final parsedDate = date is DateTime ? date : DateTime.parse(date);
    final now = DateTime.now();
    final nextDay = DateTime.now().add(Duration(days: 1));
    final dateToCheck = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(nextDay.year, nextDay.month, nextDay.day);
    return dateToCheck == today && !isSheet
        ? AppStrings.today.tr
        : dateToCheck == tomorrow && !isSheet
        ? AppStrings.tomorrow.tr
        : dateFormat(parsedDate);
  }
}
