import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/usecases/log_in_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../controller/auth_bloc.dart';
import '../widgets/custom_text_form_field.dart';

class AuthInputs extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final bool isLogin;
  const AuthInputs({
    Key? key,
    required this.isLogin,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
    required this.confirmController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !isLogin,
          child: Column(
            children: [
              CustomTextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                controller: nameController,
                hintText: AppStrings.yName.tr(),
                validator: (val) {
                  if (val!.isEmpty) {
                    return AppStrings.emptyVal.tr();
                  } else if (val.length < 4) {
                    return AppStrings.userNameValidation.tr();
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                hintText: 'Email'.tr(),
                validator: (val) {
                  if (val!.isEmpty) {
                    return AppStrings.emptyVal.tr();
                  } else if (!HelperFunctions.isEmailValid(val)) {
                    return AppStrings.emailValidation.tr();
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        Column(
          children: [
            CustomTextFormField(
              autofocus: isLogin,
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: mobileController,
              hintText: 'Mobile number'.tr(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              onFieldSubmitted: (val) {
                if (val.isNotEmpty) {
                  if (isLogin) {
                    context.read<AuthBloc>().add(
                          LoginEvent(
                            loginInputs: LoginInputs(
                              mobile: mobileController.text,
                              password: passwordController.text,
                            ),
                          ),
                        );
                  }
                }
              },
              textInputAction:
                  isLogin ? TextInputAction.done : TextInputAction.next,
              controller: passwordController,
              hintText: 'Password'.tr(),
              isScure: true,
              validator: isLogin
                  ? null
                  : (val) {
                      if (val!.isEmpty) {
                        return AppStrings.emptyVal.tr();
                      } else if (val.length < 6) {
                        return AppStrings.passwordValidation.tr();
                      } else {
                        return null;
                      }
                    },
            ),
            SizedBox(height: isLogin ? 15.h : 20.h),
          ],
        ),
        Visibility(
          visible: !isLogin,
          child: CustomTextFormField(
              onFieldSubmitted: (val) {
                if (val.isNotEmpty) {
                  context.read<AuthBloc>().add(
                        SignUpEvent(
                          signUpInputs: SignUpInputs(
                            userName: nameController.text,
                            email: emailController.text,
                            mobile: mobileController.text,
                            password: passwordController.text,
                          ),
                        ),
                      );
                }
              },
              textInputAction: TextInputAction.done,
              controller: confirmController,
              hintText: 'Confirm password'.tr(),
              isScure: true,
              validator: (val) {
                if (val!.isEmpty) {
                  return AppStrings.emptyVal.tr();
                } else if (val.length < 6) {
                  return AppStrings.passwordValidation.tr();
                } else if (passwordController.text != val) {
                  return AppStrings.confirmValidation.tr();
                } else {
                  return null;
                }
              }),
        )
      ],
    );
  }
}
