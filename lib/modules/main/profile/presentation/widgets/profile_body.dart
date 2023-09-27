import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../auth/presentation/controller/auth_bloc.dart';
import '../../domain/entities/page.dart';
import '../controller/profile_bloc.dart';
import '../pages/temp_profile_page.dart';
import 'language_widget.dart';

class ProfileBody extends StatelessWidget {
  final bool isGest;
  final List<PageEntity> pageList;
  const ProfileBody({Key? key, required this.isGest, required this.pageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppShared appShared = sl<AppShared>();
    bool arabic = context.locale == AppConstants.arabic;
    List<Map<String, dynamic>> profileUser = [
      {
        'title': AppStrings.shippingAdresses.tr(),
        'icon': 'assets/icons/address.svg',
        'onTap': () => NavigationHelper.pushNamed(
              context,
              Routes.addressesRoute,
            )
      },
      {
        'title': AppStrings.myOrders.tr(),
        'icon': 'assets/icons/orders.svg',
        'onTap': () => NavigationHelper.pushNamed(
              context,
              Routes.ordersRoute,
            )
      },
      {
        'title': AppStrings.favourites.tr(),
        'icon': 'assets/icons/favourite.svg',
        'onTap': () => NavigationHelper.pushNamed(
              context,
              Routes.favouritesRoute,
            )
      },
      {
        'title': AppStrings.wallet.tr(),
        'icon': 'assets/icons/wallet.png',
        'onTap': () => NavigationHelper.pushNamed(
              context,
              Routes.walletRoute,
            )
      },
    ];

    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Visibility(
                  visible: !isGest,
                  child: Column(
                    children: List.generate(
                      profileUser.length,
                      (index) => ListTile(
                        onTap: profileUser[index]['onTap'],
                        contentPadding: arabic
                            ? EdgeInsets.only(left: 10.w)
                            : EdgeInsets.only(right: 10.w),
                        leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorManager.primaryLight),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: ColorManager.primaryLight,
                            child: index != 3
                                ? SvgPicture.asset(profileUser[index]['icon'])
                                : Image.asset(profileUser[index]['icon']),
                          ),
                        ),
                        title: CustomText(profileUser[index]['title']),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    pageList.length,
                    (index) => ListTile(
                      onTap: () {
                        context.read<ProfileBloc>().add(
                              GetPageDetailsEvent(
                                pageId: pageList[index].id,
                              ),
                            );
                        NavigationHelper.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TempProfilePage(
                              page: pageList[index],
                            ),
                          ),
                        );
                      },
                      contentPadding: arabic
                          ? EdgeInsets.only(left: 10.w)
                          : EdgeInsets.only(right: 10.w),
                      leading: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.primaryLight),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: ColorManager.primaryLight,
                          child: SvgPicture.asset('assets/icons/orders.svg'),
                        ),
                      ),
                      title: CustomText(pageList[index].title),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () => HelperFunctions.showCustomModalBottomSheet(
                    context: context,
                    child: const LanguageWidget(),
                  ),
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.primaryLight),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: ColorManager.primaryLight,
                      child: SvgPicture.asset('assets/icons/language.svg'),
                    ),
                  ),
                  title: CustomText(AppStrings.language.tr()),
                ),
                Visibility(
                  visible: !isGest,
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthPopUpLoading) {
                        HelperFunctions.showPopUpLoadingAlert(context);
                      } else if (state is AuthLogoutSuccess ||
                          state is AuthDeleteSuccess) {
                        appShared.removeVal(AppConstants.authPassKey);
                        appShared.removeVal(AppConstants.userTokenKey);
                        appShared.removeVal(AppConstants.userLevelKey);
                        appShared.removeVal(AppConstants.priceTypeKey);
                        NavigationHelper.pushNamedAndRemoveUntil(
                          context,
                          Routes.authRoute,
                          (route) => false,
                        );
                      } else if (state is ChangePasswordSuccess) {
                        NavigationHelper.pop(context);
                        HelperFunctions.showSnackBar(context, state.msg);
                      } else if (state is AuthFailure) {
                        NavigationHelper.pop(context);
                        HelperFunctions.showSnackBar(context, state.msg);
                      }
                    },
                    builder: (context, state) {
                      return ListTile(
                        onTap: () {
                          String deviceToken =
                              appShared.getVal(AppConstants.deviceTokenKey) ??
                                  '';
                          context.read<AuthBloc>().add(
                                LogoutEvent(
                                  token: deviceToken,
                                ),
                              );
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorManager.primaryLight),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: ColorManager.primaryLight,
                            child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(
                                  HelperFunctions.rotateVal(
                                    context,
                                    rotate: true,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/logout.svg',
                                )),
                          ),
                        ),
                        title: CustomText(AppStrings.logout.tr()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // TextButton(
          //   onPressed: () => launchUrl(
          //     Uri.parse(
          //       AppConstants.itPlusSite,
          //     ),
          //   ),
          //   child: CustomText(
          //     'Powered By IT PLUS',
          //     color: ColorManager.primaryLight,
          //     fontWeight: FontWeight.w500,

          //   ),
          // )
        ],
      ),
    );
  }
}
