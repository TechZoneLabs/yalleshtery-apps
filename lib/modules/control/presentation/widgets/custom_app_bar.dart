import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/common/widgets/custom_text.dart';
import '../../../../app/helper/enums.dart';
import '../../../../app/helper/navigation_helper.dart';
import '../../../../app/utils/color_manager.dart';
import '../../../../app/utils/constants_manager.dart';
import '../../../../app/utils/routes_manager.dart';
import '../../../sub/cart/presentation/controller/cart_bloc.dart';
import '../../../sub/notification/presentation/controller/notification_bloc.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    required BuildContext context,
    bool hasBackButton = false,
    String? tempTitle,
    bool hasNotIcon = true,
    bool hasCartIcon = true,
    Key? key,
  }) : super(
          key: key,
          backgroundColor: ColorManager.kWhite,
          elevation: 0,
          leading: hasBackButton
              ? IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 25,
                  icon: Icon(Icons.arrow_back, color: ColorManager.kBlack),
                  onPressed: () => NavigationHelper.pop(context),
                )
              : null,
          title: hasBackButton && tempTitle == null
              ? null
              : CustomText(
                  tempTitle ?? AppConstants.appName,
                  color: ColorManager.kBlack,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
          centerTitle: tempTitle != null,
          actions: [
            hasNotIcon
                ? BlocConsumer<NotificationBloc, NotificationState>(
                    listener: (context, state) {
                      if (state.unReadNumStatus == Status.loaded ||
                          state.unReadNumStatus == Status.error) {
                        FlutterAppBadger.isAppBadgeSupported().then(
                          (value) {
                            if (value) {
                              FlutterAppBadger.updateBadgeCount(
                                int.parse(
                                  state.unReadNum,
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                    builder: (context, state) => IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 25,
                      icon: Badge(
                        position: BadgePosition.topEnd(top: -20),
                        showBadge: state.unReadNum != '0',
                        badgeColor: ColorManager.primaryLight,
                        badgeContent: CustomText(
                          state.unReadNum,
                          color: ColorManager.kWhite,
                          fontSize: 17.sp,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/notifications.svg',
                        ),
                      ),
                      onPressed: () => NavigationHelper.pushNamed(
                        context,
                        Routes.notificationRoute,
                      ),
                    ),
                  )
                : const Padding(padding: EdgeInsets.zero),
            hasCartIcon
                ? BlocConsumer<CartBloc, CartState>(
                    listener: (context, state) {
                      if (state.updateItemStatus == Status.updated ||
                          state.addItemStatus == Status.loaded) {
                        context.read<CartBloc>().add(
                              const GetCartDataEvent(
                                update: true,
                              ),
                            );
                      }
                    },
                    builder: (context, state) => IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 25,
                      icon: Badge(
                        position: BadgePosition.topEnd(top: -20),
                        showBadge: state.cartNum != '0',
                        badgeColor: ColorManager.primaryLight,
                        badgeContent: CustomText(
                          state.cartNum,
                          color: ColorManager.kWhite,
                          fontSize: 17.sp,
                        ),
                        child: SvgPicture.asset('assets/icons/cart.svg'),
                      ),
                      onPressed: () => NavigationHelper.pushNamed(
                        context,
                        Routes.cartRoute,
                      ),
                    ),
                  )
                : const Padding(padding: EdgeInsets.zero),
          ],
        );
}
