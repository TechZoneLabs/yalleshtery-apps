import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/usecases/log_in_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../components/auth_buttons.dart';
import '../components/auth_inputs.dart';
import '../controller/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  final bool isLogin;
  const AuthPage({Key? key, this.isLogin = true}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late bool isLogin = widget.isLogin;
  GlobalKey<FormState> authFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController signInMobileController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController signUpMobileController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  AppShared appShared = sl<AppShared>();
  @override
  void didChangeDependencies() {
    appShared.setVal(
      AppConstants.langKey,
      context.locale.languageCode,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorManager.primary2,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthChanged) {
              isLogin = state.currentState;
            } else if (state is AuthPopUpLoading) {
              HelperFunctions.showPopUpLoadingAlert(context);
            } else if (state is AuthSuccess) {
              appShared.setVal(
                AppConstants.userTokenKey,
                state.user.authenticationCode,
              );
              appShared.setVal(
                AppConstants.userLevelKey,
                state.user.userLevel,
              );
              appShared.setVal(
                AppConstants.priceTypeKey,
                state.user.priceType,
              );
              context.read<AuthBloc>().add(AddDeviceTokenEvent());
            } else if (state is AddDeviceTokenSuccess) {
              appShared.setVal(AppConstants.authPassKey, true);
              appShared.setVal(AppConstants.deviceTokenKey, state.deviceToken);
              NavigationHelper.pushNamedAndRemoveUntil(
                context,
                Routes.togglePagesRoute,
                (route) => false,
              );
            } else if (state is AuthFailure) {
              NavigationHelper.pop(context);
              HelperFunctions.showSnackBar(context, state.msg);
            }
          },
          builder: (context, state) {
            return CustomPageHeader(
              color: ColorManager.primary.withOpacity(0.2),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 30.h,
                  ),
                  child: Form(
                    key: authFormKey,
                    child: Column(
                      children: [
                        CustomText(
                          isLogin
                              ? AppStrings.login.tr()
                              : AppStrings.signUp.tr(),
                          color: ColorManager.kWhite,
                          fontSize: 20.sp,
                        ),
                        SizedBox(height: isLogin ? 135.h : 55.h),
                        AuthInputs(
                          isLogin: isLogin,
                          nameController: nameController,
                          emailController: emailController,
                          mobileController: isLogin
                              ? signInMobileController
                              : signUpMobileController,
                          passwordController: isLogin
                              ? signInPasswordController
                              : signUpPasswordController,
                          confirmController: confirmController,
                        ),
                        Visibility(
                          visible: isLogin,
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: TextButton(
                              onPressed: () => NavigationHelper.pushNamed(
                                context,
                                Routes.forgetPasswordRoute,
                              ),
                              child: CustomText(
                                AppStrings.forgetPassword.tr(),
                                color: ColorManager.kWhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: isLogin ? 120.h : 90.h),
                        AuthButtons(
                          isLogin: isLogin,
                          authFormKey: authFormKey,
                          loginFun: () => context.read<AuthBloc>().add(
                                LoginEvent(
                                  loginInputs: LoginInputs(
                                    mobile: signInMobileController.text,
                                    password: signInPasswordController.text,
                                  ),
                                ),
                              ),
                          signUpFun: () {
                            context.read<AuthBloc>().add(
                                  SignUpEvent(
                                    signUpInputs: SignUpInputs(
                                      userName: nameController.text,
                                      email: emailController.text,
                                      mobile: signUpMobileController.text,
                                      password: signUpPasswordController.text,
                                    ),
                                  ),
                                );
                          },
                          toggleFun: () {
                            FocusScope.of(context).unfocus();
                            nameController.clear();
                            emailController.clear();
                            signInMobileController.clear();
                            signInPasswordController.clear();
                            signUpMobileController.clear();
                            signUpPasswordController.clear();
                            confirmController.clear();
                            authFormKey.currentState?.reset();
                            context.read<AuthBloc>().add(
                                  AuthToggleEvent(
                                    prevState: isLogin,
                                  ),
                                );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
}
