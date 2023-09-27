import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';

class CustomTitleRow extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? color;
  const CustomTitleRow({
    Key? key,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title,
          color: color,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          maxLines: 1,
        ),
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 17.r,
            backgroundColor: ColorManager.swatch,
            child: Icon(
              Icons.arrow_forward,
              color: ColorManager.primary,
              size: 18,
            ),
          ),
        )
      ],
    );
  }
}
