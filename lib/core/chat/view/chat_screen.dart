import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_constants.dart';
import 'package:worklyn_task/constants/app_icons.dart';
import 'package:worklyn_task/constants/app_text_styles.dart';
import 'package:worklyn_task/core/chat/controller/chat_controller.dart';
import 'package:worklyn_task/core/chat/widget/task_dot.dart';
import 'package:worklyn_task/core/model/task_model.dart';
import 'package:worklyn_task/internalization/app_strings.dart';
import 'package:worklyn_task/shared/custom_input/custom_input.dart';
import 'package:worklyn_task/utils/view_utils.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          height: queryHeight(context),
          width: queryWidth(context),
          padding: EdgeInsets.symmetric(
            horizontal: queryWidth(context) * 0.03,
            vertical: 15,
          ),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.chat.tr,
                style: AppTextStyles.boldTextStyle(size: 34),
              ),
              SizedBox(height: 10),
              Obx(
                () => Expanded(
                  child: ScrollablePositionedList.builder(
                    itemScrollController: controller.scrollController,
                    itemCount: controller.messageHistory.length,
                    padding: EdgeInsets.only(
                      bottom: queryHeight(context) * 0.6,
                    ),
                    itemBuilder: (context, historyIndex) {
                      final message = controller.messageHistory[historyIndex];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          message is List
                              ? message.isEmpty
                                  ? Row(
                                    children: [
                                      Text(
                                        AppStrings.error.tr,
                                        style: AppTextStyles.regularTextStyle(
                                          size: 16,
                                          color: AppColors.red,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.error,
                                        color: AppColors.red.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ],
                                  )
                                  : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.taskCreated.tr,
                                        style: AppTextStyles.regularTextStyle(
                                          size: 12,
                                          color: AppColors.hintColor,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Column(
                                        children:
                                            message.indexed.map((
                                              (int, dynamic) item,
                                            ) {
                                              final (index, value as Task) =
                                                  item;
                                              return GestureDetector(
                                                onTap:
                                                    () => controller.editTask(
                                                      message,
                                                      value,
                                                      index,
                                                      historyIndex,
                                                    ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 20.0,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      TaskDot(),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              value.title,
                                                              style:
                                                                  AppTextStyles.regularTextStyle(
                                                                    size: 16,
                                                                  ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(height: 3),
                                                            Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  AppIcons
                                                                      .calendar,
                                                                  height: 14,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  formatDate(
                                                                    value.date,
                                                                  ),
                                                                  style: AppTextStyles.regularTextStyle(
                                                                    color:
                                                                        AppColors
                                                                            .green,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  )
                              : Align(
                                alignment:
                                    historyIndex.isEven
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(
                                    left: historyIndex.isEven ? 20 : 0,
                                    right: historyIndex.isOdd ? 20 : 0,
                                    bottom: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        historyIndex.isEven
                                            ? AppColors.secondaryColor
                                            : AppColors.inputColor,
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.inputRadius,
                                    ),
                                  ),
                                  child: Text(
                                    message,
                                    style: AppTextStyles.regularTextStyle(
                                      color: AppColors.inputTextColor,
                                    ),
                                  ),
                                ),
                              ),
                          if (controller.isLoading.value &&
                              (controller.messageHistory.length == 1 ||
                                  controller.messageHistory.length - 1 ==
                                      historyIndex))
                            LoadingAnimationWidget.waveDots(
                              color: AppColors.hintColor,
                              size: 30,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: controller.promptController,
                      hint: AppStrings.chatHint.tr,
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap:
                          controller.inputEnabled.value
                              ? controller.sendPrompt
                              : () {},
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              controller.inputEnabled.value
                                  ? AppColors.primaryColor.withValues(alpha: 1)
                                  : AppColors.primaryColor.withValues(
                                    alpha: 0.4,
                                  ),
                        ),
                        child: Icon(Icons.arrow_upward, color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
