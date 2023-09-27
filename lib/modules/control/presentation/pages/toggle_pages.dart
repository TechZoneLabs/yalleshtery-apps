import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_resume/need_resume.dart';

import '../../../../app/common/model/alert_action_model.dart';
import '../../../../app/common/widgets/custom_text.dart';
import '../../../../app/helper/enums.dart';
import '../../../../app/helper/helper_functions.dart';
import '../../../../app/helper/navigation_helper.dart';
import '../../../../app/helper/shared_helper.dart';
import '../../../../app/services/services_locator.dart';
import '../../../../app/utils/color_manager.dart';
import '../../../../app/utils/constants_manager.dart';
import '../../../../app/utils/strings_manager.dart';
import '../../../main/brands/presentation/pages/trademarks_page.dart';
import '../../../main/categories/presentation/pages/categories_page.dart';
import '../../../main/home/presentation/pages/home_page.dart';
import '../../../main/profile/presentation/pages/profile_page.dart';
import '../../../sub/cart/presentation/controller/cart_bloc.dart';
import '../../../sub/notification/presentation/controller/notification_bloc.dart';
import '../../../sub/order/presentation/controller/order_bloc.dart';
import '../../../sub/order/presentation/widgets/rate_order_widget.dart';
import '../controller/control_bloc.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_app_bar.dart';

class TogglePages extends StatefulWidget {
  const TogglePages({Key? key}) : super(key: key);

  @override
  State<TogglePages> createState() => _TogglePagesState();
}

class _TogglePagesState extends ResumableState<TogglePages> {
  int currentIndex = 0;
  PageController pageController = PageController();
  AppShared appShared = sl<AppShared>();
  late bool isGuest = appShared.getVal(AppConstants.userTokenKey) == '0';
  bool hasLoading = false;
  @override
  void initState() {
    getUnReadNotification();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isGuest) {
      context.read<CartBloc>().add(
            const GetCartDataEvent(
              forceRest: true,
            ),
          );
    }
    notifyListener();
    super.didChangeDependencies();
  }

  notifyListener() {
    int lastMessageId = 0;
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        Map<String, dynamic> data = message.data;
        int messageId = int.parse(data.isNotEmpty ? data['id'] : '0');
        if (lastMessageId != messageId) {
          lastMessageId = messageId;
          getUnReadNotification();
          HelperFunctions.showAlert(
            context: context,
            title: AppStrings.newNotification.tr(),
            content: CustomText(
              data['body'].toString(),
            ),
            actions: [
              AlertActionModel(
                title: AppStrings.open.tr(),
                onPressed: () {
                  NavigationHelper.pop(context);
                  HelperFunctions.handleNotificationAction(
                    context: context,
                    message: message,
                  );
                },
              ),
              AlertActionModel(
                title: AppStrings.close.tr(),
                onPressed: () => NavigationHelper.pop(context),
              ),
            ],
          );
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => HelperFunctions.handleNotificationAction(
        context: context,
        message: message,
      ),
    );
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          HelperFunctions.handleNotificationAction(
            context: context,
            message: message,
          );
        }
      },
    );
  }

  getUnReadNotification() =>
      context.read<NotificationBloc>().add(GetUnReadNotificationEvent());

  @override
  void onResume() {
    getUnReadNotification();
    context.read<ControlBloc>().add(GetContactInfoEvent());
    HelperFunctions.checkUpdate(context).then((value) {
      if (!value) {
        if (appShared.getVal(AppConstants.rateOrderkKey) == null && !isGuest) {
          context.read<OrderBloc>().add(GetUnRatedOrderEvent());
        }
      }
    });
    super.onResume();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorManager.background,
        appBar: CustomAppBar(
          context: context,
          hasCartIcon: !isGuest,
        ),
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state.getUnRatedOrderStatus == Status.loading ||
                state.rateOrderStatus == Status.loading) {
              hasLoading = true;
            } else if (state.getUnRatedOrderStatus == Status.loaded ||
                state.getUnRatedOrderStatus == Status.error) {
              if (hasLoading) {
                hasLoading = false;
                if (state.unRatedOrderId.isNotEmpty) {
                  appShared.setVal(AppConstants.rateOrderkKey, true);
                  HelperFunctions.showCustomModalBottomSheet(
                    context: context,
                    child: RateOrderWidget(
                      unRatedOrderId: state.unRatedOrderId,
                    ),
                  ).then(
                    (_) => appShared.removeVal(
                      AppConstants.rateOrderkKey,
                    ),
                  );
                }
              }
            } else if (state.rateOrderStatus == Status.loaded ||
                state.rateOrderStatus == Status.error) {
              if (hasLoading) {
                hasLoading = false;
                if (state.rateOrderStatus == Status.loaded) {
                  NavigationHelper.pop(context);
                } else {
                  HelperFunctions.showSnackBar(context, state.msg);
                }
              }
            }
          },
          builder: (context, state) => PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (value) => setState(() => currentIndex = value),
            children: const [
              HomePage(),
              CategoriesPage(),
              TrademarksPage(),
              ProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: (val) => pageController.jumpToPage(val),
        ),
      );
}
