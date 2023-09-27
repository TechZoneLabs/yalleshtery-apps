import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';

class CustomProductListenWidget extends StatelessWidget {
  final void Function(String val) onClick;
  const CustomProductListenWidget({Key? key, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: CustomText(
                  AppStrings.haveNote.tr(),
                ),
              ),
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: CloseButton(
                  onPressed: () => onClick(textEditingController.text),
                ),
              ),
            ],
          ),
          TextFormField(
            maxLines: 4,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: AppStrings.noteDescription.tr(),
              focusedBorder: OutlineInputBorder(
                // borderSide: const BorderSide(
                //     color:
                //         Colors.transparent),
                borderRadius: BorderRadius.circular(8.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () => onClick(textEditingController.text),
                  title: AppStrings.cancel,
                  titleColor: ColorManager.kBlack.withOpacity(0.7),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomElevatedButton(
                  priColor: ColorManager.primaryLight,
                  titleColor: ColorManager.kWhite,
                  onPressed: () => onClick(textEditingController.text),
                  title: AppStrings.confirm,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
