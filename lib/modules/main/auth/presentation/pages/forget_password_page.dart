import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo/app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../controller/auth_bloc.dart';
import '../widgets/custom_text_form_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: ColorManager.primary2,
      appBar: AppBar(
        backgroundColor: ColorManager.kWhite,
        elevation: 0,
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
          AppStrings.forgetPasswordTilte.tr(),
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: CustomPageHeader(
        color: ColorManager.primary.withOpacity(0.2),
        child: SafeArea(
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 30.h,
                ),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordSuccess) {
                      FocusScope.of(context).unfocus();
                      emailController = TextEditingController();
                      forgetFormKey.currentState?.reset();
                      NavigationHelper.pop(context);
                      HelperFunctions.showSnackBar(context, state.msg);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: forgetFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 130.h),
                              CustomText(
                                AppStrings.clickToHavepassword.tr(),
                                color: ColorManager.kWhite,
                              ),
                              SizedBox(height: 24.h),
                              CustomTextFormField(
                                autofocus: true,
                                onFieldSubmitted: (val) {
                                  if (val.isNotEmpty) {
                                    context.read<AuthBloc>().add(
                                          ForgetPasswordEvent(
                                            email: val,
                                          ),
                                        );
                                  }
                                },
                                hintText: 'Enter your email'.tr(),
                                controller: emailController,
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            height: 55.h,
                            width: ScreenUtil().screenWidth,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.kWhite,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.r))),
                              onPressed: () {
                                if (forgetFormKey.currentState!.validate()) {
                                  forgetFormKey.currentState!.save();
                                  context.read<AuthBloc>().add(
                                        ForgetPasswordEvent(
                                          email: emailController.text,
                                        ),
                                      );
                                }
                              },
                              child: CustomText(
                                AppStrings.continueProgress.tr(),
                                color: ColorManager.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
