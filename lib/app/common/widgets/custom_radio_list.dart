import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_manager.dart';
import 'custom_text.dart';

class CustomRadioList extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function() onTap;
  const CustomRadioList(
      {Key? key,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      tileColor: selected ? ColorManager.swatch : null,
      title: CustomText(
        title,
      ),
      trailing: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected
                ? ColorManager.primaryLight
                : ColorManager.kBlack.withOpacity(0.7),
          ),
        ),
        child: CircleAvatar(
          radius: 7.r,
          backgroundColor:
              selected ? ColorManager.primaryLight : ColorManager.kWhite,
        ),
      ),
    );
  }
}
