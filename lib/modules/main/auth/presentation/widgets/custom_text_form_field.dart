import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isScure;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style, hintStyle;
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.isScure = false,
    required this.controller,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.autofocus = false,
    this.textInputType,
    this.inputFormatters,
    this.style,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showContent = false;
    return StatefulBuilder(
      builder: (context, innerState) => TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: textInputType,
        autofocus: autofocus,
        inputFormatters: inputFormatters,
        validator: validator ??
            (value) => value!.isEmpty ? AppStrings.emptyVal.tr() : null,
        style: style,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isScure && !showContent,
        decoration: InputDecoration(
          fillColor: ColorManager.kWhite,
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.r),
          ),
          errorStyle: TextStyle(color: ColorManager.kOrange),
          errorMaxLines: 3,
          suffixIcon: isScure
              ? GestureDetector(
                  onTap: () => innerState(() => showContent = !showContent),
                  child: Icon(
                    showContent ? Icons.visibility : Icons.visibility_off,
                    color: ColorManager.kBlack,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}
