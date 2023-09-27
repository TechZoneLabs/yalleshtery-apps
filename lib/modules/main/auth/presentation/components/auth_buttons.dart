import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../widgets/custom_elevated_button.dart';

class AuthButtons extends StatelessWidget {
  final bool isLogin;
  final Function() loginFun;
  final Function() signUpFun;
  final void Function() toggleFun;
  final GlobalKey<FormState> authFormKey;
  const AuthButtons({
    Key? key,
    required this.isLogin,
    required this.loginFun,
    required this.signUpFun,
    required this.toggleFun,
    required this.authFormKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          onPressed: () {
            if (authFormKey.currentState!.validate()) {
              authFormKey.currentState!.save();
              if (isLogin) {
                loginFun();
              } else {
                signUpFun();
              }
            }
          },
          title: isLogin ? AppStrings.login : AppStrings.createAccount,
          priColor: ColorManager.primaryLight,
          titleColor: ColorManager.kWhite,
        ),
        SizedBox(height: 25.h),
        CustomText(
          isLogin ? AppStrings.noHaveAccount.tr() : AppStrings.haceAccount.tr(),
          color: ColorManager.kWhite,
        ),
        SizedBox(height: 12.h),
        CustomElevatedButton(
          onPressed: toggleFun,
          title: isLogin ? AppStrings.createAccount : AppStrings.login,
        ),
      ],
    );
  }
}
