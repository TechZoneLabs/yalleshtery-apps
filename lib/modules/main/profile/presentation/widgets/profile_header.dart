import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/pages/auth_page.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';

class ProfileHeader extends StatelessWidget {
  final bool isGest;
  final User? user;
  const ProfileHeader({Key? key, required this.isGest, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGest
        ? Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: ColorManager.primaryLight,
                  child: SvgPicture.asset('assets/icons/account.svg'),
                ),
                title: CustomText(AppStrings.hiGuest.tr()),
                subtitle: CustomText(AppStrings.signToContinue.tr()),
              ),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                onPressed: () {
                  NavigationHelper.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(
                        isLogin: false,
                      ),
                    ),
                    (route) => false,
                  );
                },
                priColor: ColorManager.primaryLight,
                titleColor: ColorManager.kWhite,
                title: AppStrings.createAccount,
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                onPressed: () => NavigationHelper.pushNamedAndRemoveUntil(
                  context,
                  Routes.authRoute,
                  (route) => false,
                ),
                title: AppStrings.signIn,
              ),
              SizedBox(height: 5.h),
            ],
          )
        : user != null
            ? ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: ColorManager.primaryLight,
                  child: SvgPicture.asset('assets/icons/account.svg'),
                ),
                title: CustomText(user!.userName),
                subtitle: CustomText(user!.mobile),
                trailing: IconButton(
                  onPressed: () => NavigationHelper.pushNamed(
                    context,
                    Routes.editProfileRoute,
                  ),
                  icon: SvgPicture.asset('assets/icons/edit.svg'),
                ),
              )
            : ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: ColorManager.primaryLight,
                  child: SvgPicture.asset('assets/icons/account.svg'),
                ),
              );
  }
}
