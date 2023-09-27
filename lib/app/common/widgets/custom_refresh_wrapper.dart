import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:scroll_edge_listener/scroll_edge_listener.dart';

import '../../../modules/sub/cart/presentation/controller/cart_bloc.dart';
import '../../../modules/sub/notification/presentation/controller/notification_bloc.dart';
import '../../helper/shared_helper.dart';
import '../../services/services_locator.dart';
import '../../utils/color_manager.dart';
import '../../utils/constants_manager.dart';

class CustomRefreshWrapper extends StatelessWidget {
  final ScrollController scrollController;
  final Function() refreshData;
  final Function()? onListen;
  final Widget Function(
    BuildContext context,
    ScrollViewProperties properties,
  ) builder;
  final bool alwaysVisibleAtOffset;
  const CustomRefreshWrapper({
    Key? key,
    required this.refreshData,
    required this.builder,
    this.onListen,
    required this.scrollController,
    this.alwaysVisibleAtOffset = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuest = sl<AppShared>().getVal(AppConstants.userTokenKey) == '0';
    bool arabic = context.locale == AppConstants.arabic;
    return onListen == null
        ? _customRefreshIndicator(
            context: context,
            isGuest: isGuest,
            child: _customScrollWrapper(
              arabic: arabic,
            ),
          )
        : _customScrollEdgeListener(
            child: _customRefreshIndicator(
              context: context,
              isGuest: isGuest,
              child: _customScrollWrapper(
                arabic: arabic,
              ),
            ),
          );
  }

  Widget _customScrollEdgeListener({
    required Widget child,
  }) =>
      ScrollEdgeListener(
        edge: ScrollEdge.end,
        edgeOffset: 100,
        continuous: false,
        debounce: const Duration(milliseconds: 500),
        dispatch: true,
        listener: onListen ?? () {},
        child: child,
      );
  Widget _customRefreshIndicator({
    required BuildContext context,
    required Widget child,
    required bool isGuest,
  }) =>
      RefreshIndicator(
        color: ColorManager.primaryLight,
        backgroundColor: ColorManager.background,
        onRefresh: () {
          refreshData();
          context.read<NotificationBloc>().add(
                GetUnReadNotificationEvent(),
              );
          if (!isGuest) {
            context.read<CartBloc>().add(
                  const GetCartDataEvent(
                    forceRest: true,
                  ),
                );
          }
          return Future.value();
        },
        child: child,
      );
  Widget _customScrollWrapper({required bool arabic}) => ScrollWrapper(
        scrollController: scrollController,
        alwaysVisibleAtOffset: alwaysVisibleAtOffset,
        promptAlignment: arabic ? Alignment.bottomRight : Alignment.bottomLeft,
        scrollOffsetUntilVisible: 10,
        promptTheme: PromptButtonTheme(
          icon: Icon(
            Icons.arrow_upward,
            color: ColorManager.kBlack,
          ),
          color: ColorManager.primaryLight,
        ),
        builder: builder,
      );
}
