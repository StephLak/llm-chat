import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_icons.dart';
import 'package:worklyn_task/constants/app_text_styles.dart';
import 'package:worklyn_task/core/chat/widget/custom_chip.dart';

class DateChip extends StatelessWidget {
  const DateChip({
    super.key,
    required this.text,
    required this.onTap,
    this.hasIcon = false,
  });

  final String text;
  final Function() onTap;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: GestureDetector(
        onTap: onTap,
        child: CustomChip(
          child: Row(
            children: [
              if (hasIcon)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SvgPicture.asset(AppIcons.noDate),
                ),
              Text(
                text,
                style: AppTextStyles.mediumTextStyle(
                  size: 16,
                  color: AppColors.chipColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
