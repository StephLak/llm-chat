import 'package:flutter/material.dart';
import 'package:worklyn_task/constants/app_colors.dart';
import 'package:worklyn_task/constants/app_constants.dart';
import 'package:worklyn_task/constants/app_text_styles.dart';
import 'package:worklyn_task/shared/custom_input/app_input_border.dart';

class CustomInput extends StatefulWidget {
  final String? hint;
  final double? height;
  final TextEditingController? controller;

  const CustomInput({super.key, this.hint, this.controller, this.height});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    Widget textField = TextFormField(
      enableInteractiveSelection: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      style: AppTextStyles.regularTextStyle(
        color: AppColors.inputTextColor,
        size: 16,
      ),
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),

        hintText: widget.hint,
        hintStyle: AppTextStyles.regularTextStyle(color: AppColors.hintColor),
        counterText: '',
        filled: true,
        fillColor: AppColors.inputColor,
        focusedBorder: AppInputBorders.focusedBorder,
        border: AppInputBorders.border,
        enabledBorder: AppInputBorders.border,
      ),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.inputRadius),
        child: textField,
      ),
    );
  }
}
