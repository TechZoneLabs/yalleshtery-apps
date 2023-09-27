import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helper/helper_functions.dart';
import '../../helper/navigation_helper.dart';
import '../../utils/color_manager.dart';
import '../../utils/routes_manager.dart';
import 'custom_text.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.kGrey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => NavigationHelper.pushNamed(
                context,
                Routes.searchRoute,
              ),
              child: Row(
                children: [
                  Transform(
                      alignment: AlignmentDirectional.center,
                      transform: Matrix4.rotationY(
                        HelperFunctions.rotateVal(
                          context,
                          rotate: true,
                        ),
                      ),
                      child: SvgPicture.asset('assets/icons/search.svg')),
                  SizedBox(width: 15.w),
                  CustomText(
                    'Search brands or products'.tr(),
                    fontSize: 14.sp,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => NavigationHelper.pushNamed(
              context,
              Routes.barCodeRoute,
            ),
            child: SvgPicture.asset('assets/icons/barcode.svg'),
          ),
        ],
      ),
    );
  }
}
