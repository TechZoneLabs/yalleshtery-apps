import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/common/widgets/custom_text.dart';
import '../../../../app/helper/navigation_helper.dart';
import '../../../../app/helper/shared_helper.dart';
import '../../../../app/services/services_locator.dart';
import '../../../../app/utils/color_manager.dart';
import '../../../../app/utils/constants_manager.dart';
import '../../../../app/utils/routes_manager.dart';
import '../../../../app/utils/strings_manager.dart';
import '../../../main/auth/presentation/widgets/custom_elevated_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppShared appShared = sl<AppShared>();
    int currentIndex = 0;
    List<Map<String, String>> pageList = [
      {
        'title': 'welcome-title1'.tr(),
        'subTitle': 'welcome-subTitle1'.tr(),
      },
      {
        'title': 'welcome-title2'.tr(),
        'subTitle': 'welcome-subTitle2'.tr(),
      },
      {
        'title': 'welcome-title3'.tr(),
        'subTitle': 'welcome-subTitle3'.tr(),
      },
    ];
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 58.h),
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Expanded(
              child: StatefulBuilder(
                builder: (context, innerState) => Column(
                  children: [
                    Expanded(
                      child: PageView(
                        onPageChanged: (value) => innerState(
                          () => currentIndex = value,
                        ),
                        children: List.generate(
                          pageList.length,
                          (index) => Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/welcome/wel-slider${index + 1}.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              CustomText(
                                pageList[index]['title']!,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w800,
                                fontSize: 18.sp,
                              ),
                              SizedBox(height: 4.h),
                              CustomText(
                                pageList[index]['subTitle']!,
                                maxLines: 2,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                color: ColorManager.kGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 5),
                          height: 10.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: index <= currentIndex
                                ? ColorManager.kBlack
                                : ColorManager.kGrey,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            CustomElevatedButton(
              priColor: ColorManager.primaryLight,
              titleColor: ColorManager.kWhite,
              onPressed: () {
                appShared.setVal(
                  AppConstants.userTokenKey,
                  '0',
                );
                // appShared.setVal(
                //   AppConstants.welPassKey,
                //   true,
                // );
                NavigationHelper.pushReplacementNamed(
                  context,
                  Routes.togglePagesRoute,
                );
              },
              title: AppStrings.skip,
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              onPressed: () {
                // appShared.setVal(
                //   AppConstants.welPassKey,
                //   true,
                // );
                NavigationHelper.pushReplacementNamed(
                  context,
                  Routes.authRoute,
                );
              },
              title: AppStrings.login,
            ),
          ],
        ),
      ),
    );
  }
}
