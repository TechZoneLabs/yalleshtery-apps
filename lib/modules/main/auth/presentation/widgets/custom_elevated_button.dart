import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.priColor,
    this.titleColor,
    this.getTitleWidth = false,
  }) : super(key: key);

  final Color? priColor, titleColor;
  final double? height, width;
  final void Function()? onPressed;
  final String title;
  final bool getTitleWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55.h,
      width: getTitleWidth ? null : width ?? ScreenUtil().screenWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: priColor ?? ColorManager.kWhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r))),
        onPressed: onPressed,
        child: CustomText(
          title.tr(),
          color: titleColor ?? ColorManager.primaryLight,fontSize: 16.sp,
        ),
      ),
    );
  }
}
