import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_icons.dart';
import 'package:worklyn_task/constants/app_text_styles.dart';
import 'package:worklyn_task/core/chat/widget/custom_chip.dart';
import 'package:worklyn_task/core/chat/widget/date_chip.dart';
import 'package:worklyn_task/core/chat/widget/task_dot.dart';
import 'package:worklyn_task/internalization/app_strings.dart';
import 'package:worklyn_task/utils/view_utils.dart';

class Task {
  String text;
  DateTime date;

  Task({required this.text, required this.date});
}

class ChatController extends GetxController {
  TextEditingController promptController = TextEditingController();
  final ItemScrollController scrollController = ItemScrollController();
  RxBool inputEnabled = false.obs;
  RxBool isLoading = false.obs;
  RxList<dynamic> tasks = RxList<dynamic>();
  RxString prompt = ''.obs;
  String userId = '';
  RxList messageHistory = [].obs;
  RxBool isEdit = false.obs;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  void _scrollLastToTop() {
    scrollController.scrollTo(
      index: messageHistory.length - 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0, // 0.0 = top of the screen
    );
  }

  dynamic getTasks(String rawText) {
    dynamic result;
    try {
      if (rawText.contains('1.')) {
        if (rawText.contains('**1. ')) {
          final RegExp pattern = RegExp(
            r'\*\*(\d+\.\s*[^:]+):\*\*\s*(.*?)(?=(\*\*\d+\.|\Z))',
            dotAll: true,
          );
          final String today = DateTime.now().toIso8601String();

          final List<Map<String, String>> tasks =
              pattern.allMatches(rawText).map((match) {
                final title = match.group(1)?.trim() ?? '';
                final body =
                    match.group(2)?.trim().replaceAll(RegExp(r'\s+'), ' ') ??
                    '';
                return {'title': title, 'body': body, 'date': today};
              }).toList();
          print(tasks[0]);
          inspect(tasks);
          result = tasks;
        } else if (rawText.contains('1. **')) {
          final RegExp pattern = RegExp(
            r'(\d+)\.\s+\*\*(.*?)\*\*\s+(.*?)(?=\d+\.\s+\*\*|$)',
            dotAll: true,
          );

          // Extract matches using the RegExp
          final matches = pattern.allMatches(rawText);

          // Get today's date in 'yyyy-MM-dd' format
          final today = DateTime.now().toIso8601String();

          // Map matches to a list of tasks with title, body, and date
          final tasks =
              matches.map((match) {
                final title = match.group(2)?.trim() ?? '';
                final body =
                    match.group(3)?.replaceAll(RegExp(r'\s+'), ' ').trim() ??
                    '';
                return {'title': title, 'body': body, 'date': today};
              }).toList();
          print(tasks[0]);
          inspect(tasks);
          result = tasks;
        } else {
          final RegExp sectionRegex =
              rawText.contains('**1.')
                  ? RegExp(
                    r'\*\*(\d+\.\s*[^\n]*)\n((?:(?!\*\*\d+\.).|\n)+)',
                    multiLine: true,
                  )
                  : RegExp(
                    r'###\s*(\d+\.\s*[^\n]*)\n((?:(?!###\s*\d+\.).|\n)+)',
                    multiLine: true,
                  );
          final String today = DateTime.now().toIso8601String();
          // final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

          final List<Map<String, String>> tasks =
              sectionRegex.allMatches(rawText).map((match) {
                final title = match.group(1)?.trim() ?? '';
                final body =
                    match.group(2)?.trim().replaceAll(RegExp(r'\n'), ' ') ?? '';

                return {'title': title, 'body': body, 'date': today};
              }).toList();
          print(tasks[0]);
          inspect(tasks);
          result = tasks;
        }
      } else {
        result = rawText;
      }
    } catch (e) {
      result = rawText;
    }
    return result;
  }

  // Listener to check if input is empty or not
  updateInputEnabled() {
    inputEnabled.value = promptController.text.trim().isNotEmpty;
  }

  Future<void> sendPrompt() async {
    prompt.value = promptController.text.trim();
    messageHistory.add(prompt.value);
    promptController.clear();
    if (messageHistory.length > 1) {
      _scrollLastToTop();
    }
    isLoading.value = true;

    try {
      final response = await http.put(
        Uri.parse('https://api.worklyn.com/konsul/assistant.chat'),
        headers: {
          'X-Environment': 'production',
          'Content-Type': 'application/json',
          if (userId.isNotEmpty) 'Cookie': 'id=$userId',
        },
        body: jsonEncode({
          'message': prompt.value,
          'source': {'id': userId.isNotEmpty ? userId : '1', 'deviceId': 1},
        }),
      );
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        messageHistory.add(getTasks(data['message']));
        if (data['userId'] != null) {
          userId = data['userId'];
        }
      } else {
        showSnackbarMessage(message: response.reasonPhrase!);
      }
    } catch (e) {
      showSnackbarMessage(message: AppStrings.genericErrorMessage.tr);
    } finally {
      if (messageHistory.length.isOdd) {
        messageHistory.removeLast();
      }
      isLoading.value = false;
    }
  }

  setDate(DateTime? date, int historyIndex, int index) {
    selectedDate.value = date;
    messageHistory[historyIndex][index]['date'] =
        date == null ? '' : date.toIso8601String();
    Get.forceAppUpdate();
  }

  editTask(List items, dynamic task, int index, int historyIndex) {
    selectedDate.value =
        task['date'] == '' ? DateTime.now() : DateTime.parse(task['date']);
    showAppBottomSheet(
      willPop: false,
      isDismissible: false,
      height: queryHeight(null),
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: queryWidth(null) * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: queryWidth(null) * 0.1,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppColors.closeIndicator,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isEdit.value
                          ? GestureDetector(
                            onTap: () => isEdit.value = false,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.primaryColor,
                                ),

                                Text(
                                  AppStrings.editTask.tr,
                                  style: AppTextStyles.mediumTextStyle(
                                    size: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : SizedBox(width: 60),
                      Text(
                        isEdit.value
                            ? AppStrings.chooseDate.tr
                            : AppStrings.editTask.tr,
                        style: AppTextStyles.boldTextStyle(
                          size: 18,
                          color: AppColors.deepText,
                        ),
                      ),
                      isEdit.value
                          ? SizedBox(width: 80)
                          : GestureDetector(
                            onTap: () {
                              messageHistory[historyIndex].removeAt(index);
                              Get.forceAppUpdate();
                              Get.back();
                            },
                            child: Text(
                              AppStrings.delete.tr,
                              style: AppTextStyles.boldTextStyle(
                                size: 18,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                    ],
                  ),

                  isEdit.value
                      ? Container(
                        height: 44,
                        margin: EdgeInsets.only(top: 30, bottom: 10),
                        width: queryWidth(null),
                        padding: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          formatDate(selectedDate.value),
                          style: AppTextStyles.regularTextStyle(
                            size: 16,
                            color: AppColors.dateColor,
                          ),
                        ),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              children: [
                                TaskDot(
                                  color: AppColors.deepText,
                                  hasLeftPadding: false,
                                ),
                                Expanded(
                                  child: Text(
                                    task['title'],
                                    style: AppTextStyles.regularTextStyle(
                                      size: 16,
                                      color: AppColors.deepText,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => isEdit.value = true,
                            child: CustomChip(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.calendar,
                                    height: 14,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    formatDate(task['date'], isSheet: true),
                                    style: AppTextStyles.mediumTextStyle(
                                      color: AppColors.green,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
            Divider(color: AppColors.dividerColor),
            isEdit.value
                ? Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 12,
                    left: queryWidth(null) * 0.05,
                  ),
                  child: Row(
                    children: [
                      DateChip(
                        text: AppStrings.today.tr,
                        onTap:
                            () => setDate(DateTime.now(), historyIndex, index),
                      ),
                      DateChip(
                        text: AppStrings.tomorrow.tr,
                        onTap:
                            () => setDate(
                              DateTime.now().add(Duration(days: 1)),
                              historyIndex,
                              index,
                            ),
                      ),
                      DateChip(
                        text: AppStrings.noDate.tr,
                        onTap: () => setDate(null, historyIndex, index),
                        hasIcon: true,
                      ),
                    ],
                  ),
                )
                : Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: queryWidth(null) * 0.05,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: AppColors.deepText),
                      SizedBox(width: 10),
                      Text(
                        AppStrings.addSubtask.tr,
                        style: AppTextStyles.regularTextStyle(
                          color: AppColors.deepText,
                        ),
                      ),
                    ],
                  ),
                ),

            isEdit.value
                ? Column(
                  children: [
                    Divider(color: AppColors.dividerColor),
                    TableCalendar(
                      firstDay: DateTime.now().subtract(Duration(days: 1)),
                      lastDay: DateTime.utc(5000, 12, 31),
                      focusedDay: selectedDate.value ?? DateTime.now(),
                      selectedDayPredicate:
                          (day) => isSameDay(
                            selectedDate.value ?? DateTime.now(),
                            day,
                          ),
                      onDaySelected:
                          (selectedDay, focusedDay) =>
                              setDate(selectedDay, historyIndex, index),
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: AppColors.textColor,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    promptController.addListener(updateInputEnabled);
    super.onInit();
  }
}
