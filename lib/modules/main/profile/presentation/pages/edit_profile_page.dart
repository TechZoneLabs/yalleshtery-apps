import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/usecases/change_password_use_case.dart';
import '../../../auth/domain/usecases/update_profile_use_case.dart';
import '../../../auth/presentation/controller/auth_bloc.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';
import '../controller/profile_bloc.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> personalKey = GlobalKey<FormState>();
    GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController oldPassController = TextEditingController();
    TextEditingController newPassController = TextEditingController();
    TextEditingController cofirmPassController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.background,
        leading: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 25,
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.kBlack,
          ),
          onPressed: () => NavigationHelper.pop(context),
        ),
        centerTitle: true,
        title: CustomText(
          AppStrings.editProfile.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: CustomPageHeader(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state.userStatus == Status.loaded) {
                    User user = state.user!;
                    nameController.text = user.userName;
                    emailController.text = user.email;
                    phoneController.text = user.mobile;
                  }
                  return CustomElevatedButton(
                    title: AppStrings.editProfile,
                    priColor: ColorManager.primaryLight,
                    titleColor: ColorManager.kWhite,
                    onPressed: () => HelperFunctions.showCustomDialog(
                      context: context,
                      child: Form(
                        key: personalKey,
                        child: EditProfileWidget(
                          title: AppStrings.personalDetails,
                          textList: [
                            {
                              'icon': Icons.person,
                              'obscureText': false,
                              'validator': null,
                              'hintText': AppStrings.yName,
                              'keyboardType': TextInputType.name,
                              'textInputAction': TextInputAction.next,
                              'controller': nameController
                            },
                            {
                              'icon': Icons.email_outlined,
                              'obscureText': false,
                              'validator': null,
                              'hintText': AppStrings.email,
                              'keyboardType': TextInputType.emailAddress,
                              'textInputAction': TextInputAction.next,
                              'controller': emailController
                            },
                            {
                              'icon': Icons.phone_android,
                              'obscureText': false,
                              'validator': null,
                              'hintText': AppStrings.mobile,
                              'keyboardType': TextInputType.phone,
                              'textInputAction': TextInputAction.done,
                              'controller': phoneController
                            }
                          ],
                          confirm: () {
                            if (personalKey.currentState!.validate()) {
                              personalKey.currentState!.save();
                              NavigationHelper.pop(context);
                              context.read<ProfileBloc>().add(
                                    UpdateProfileEvent(
                                      updateInputs: UpdateInputs(
                                        userName: nameController.text,
                                        email: emailController.text,
                                        mobile: phoneController.text,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                onPressed: () => HelperFunctions.showCustomDialog(
                  context: context,
                  child: Form(
                    key: passwordKey,
                    child: EditProfileWidget(
                      title: AppStrings.changePassword,
                      textList: [
                        {
                          'icon': Icons.lock,
                          'obscureText': true,
                          'validator': null,
                          'hintText': AppStrings.kOldPassword,
                          'keyboardType': null,
                          'textInputAction': TextInputAction.next,
                          'controller': oldPassController
                        },
                        {
                          'icon': Icons.lock,
                          'obscureText': true,
                          'validator': null,
                          'hintText': AppStrings.kNewPassword,
                          'keyboardType': null,
                          'textInputAction': TextInputAction.next,
                          'controller': newPassController
                        },
                        {
                          'icon': Icons.lock,
                          'obscureText': true,
                          'validator': null,
                          'hintText': AppStrings.confirmPassword,
                          'keyboardType': null,
                          'textInputAction': TextInputAction.done,
                          'controller': cofirmPassController
                        }
                      ],
                      isPassword: true,
                      confirm: () {
                        if (passwordKey.currentState!.validate()) {
                          passwordKey.currentState!.save();
                          NavigationHelper.pop(context);
                          context.read<AuthBloc>().add(
                                ChangePasswordEvent(
                                  passwordInputs: PasswordInputs(
                                    oldPassword: oldPassController.text,
                                    newPassword: newPassController.text,
                                    confirmPassword: cofirmPassController.text,
                                  ),
                                ),
                              );
                        }
                      },
                    ),
                  ),
                ),
                title: AppStrings.changePassword,
                priColor: ColorManager.primaryLight,
                titleColor: ColorManager.kWhite,
              ),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                onPressed: () {
                  String deviceToken =
                      sl<AppShared>().getVal(AppConstants.deviceTokenKey) ?? '';
                  context.read<AuthBloc>().add(DeleteEvent(token: deviceToken));
                },
                title: AppStrings.deleteAccount,
                priColor: ColorManager.kRed,
                titleColor: ColorManager.kWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({
    Key? key,
    required this.title,
    required this.textList,
    required this.confirm,
    this.isPassword = false,
  }) : super(key: key);
  final String title;
  final List<Map<String, dynamic>> textList;
  final bool isPassword;
  final void Function() confirm;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Column(
        children: [
          CustomText(
            title.tr(),
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
          SizedBox(height: 20.h),
          Column(
            children: List.generate(
              textList.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: EditProfileTextForm(
                  isPassword: isPassword,
                  icon: textList[index]['icon'],
                  obscureText: textList[index]['obscureText'],
                  hintText: (textList[index]['hintText'] as String).tr(),
                  keyboardType: textList[index]['keyboardType'],
                  textInputAction: textList[index]['textInputAction'],
                  controller: textList[index]['controller'],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          CustomElevatedButton(
            onPressed: confirm,
            title: AppStrings.confirm,
            priColor: ColorManager.primaryLight,
            titleColor: ColorManager.kWhite,
          ),
          SizedBox(height: 20.h),
          CustomElevatedButton(
            onPressed: () => NavigationHelper.pop(context),
            title: AppStrings.cancel,
          ),
        ],
      ),
    );
  }
}

class EditProfileTextForm extends StatelessWidget {
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool isPassword;
  const EditProfileTextForm({
    Key? key,
    required this.icon,
    this.keyboardType,
    required this.controller,
    required this.hintText,
    this.textInputAction,
    this.obscureText = false,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showContent = false;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: ColorManager.swatch,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: StatefulBuilder(
              builder: (context, innerState) => Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                      obscureText: obscureText && !showContent,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorMaxLines: 3,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 1.0,
                          horizontal: 0.0,
                        ),
                        hintText: hintText,
                      ),
                      validator: validator ??
                          (value) => value!.isEmpty
                              ? AppStrings.emptyVal.tr()
                              : isPassword && value.length < 6
                                  ? AppStrings.passwordValidation.tr()
                                  : null,
                    ),
                  ),
                  obscureText
                      ? GestureDetector(
                          onTap: () =>
                              innerState(() => showContent = !showContent),
                          child: Icon(
                            showContent
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        )
                      : const Padding(padding: EdgeInsets.zero),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
