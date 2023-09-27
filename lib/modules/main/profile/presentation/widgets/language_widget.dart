import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_radio_list.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale tempLocal = context.locale;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      child: StatefulBuilder(
        builder: (context, langState) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: CustomText(AppStrings.chooseLang.tr()),
                ),
                ButtonTheme(
                  padding: EdgeInsets.zero,
                  child: const CloseButton(),
                ),
              ],
            ),
            const Divider(),
            CustomRadioList(
              title: AppStrings.english.tr(),
              selected: tempLocal == AppConstants.english,
              onTap: () {
                if (tempLocal == AppConstants.arabic) {
                  langState(
                    () {
                      tempLocal = AppConstants.english;
                    },
                  );
                }
              },
            ),
            CustomRadioList(
              title: AppStrings.arabic.tr(),
              selected: tempLocal == AppConstants.arabic,
              onTap: () {
                if (tempLocal == AppConstants.english) {
                  langState(
                    () => tempLocal = AppConstants.arabic,
                  );
                }
              },
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: tempLocal == context.locale
                        ? null
                        : () {
                            context.setLocale(tempLocal);
                            sl<AppShared>().setVal(
                              AppConstants.langKey,
                              tempLocal.languageCode,
                            );
                            Phoenix.rebirth(context);
                          },
                    title: AppStrings.change,
                    priColor: ColorManager.primaryLight,
                    titleColor: ColorManager.kWhite,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () => NavigationHelper.pop(context),
                    title: AppStrings.cancel,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
