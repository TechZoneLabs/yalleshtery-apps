import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../controller/notification_bloc.dart';
import '../widgets/notification_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool alertOpen = false;
  ScrollController scrollController = ScrollController();
  late NotificationBloc notificationBloc = context.read<NotificationBloc>();
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  void getPageData({int start = 0}) {
    notificationBloc.add(GetNotificationsEvent(start: start));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.background,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 25,
          icon: Icon(Icons.arrow_back, color: ColorManager.kBlack),
          onPressed: () => NavigationHelper.pop(context),
        ),
        title: CustomText(
          AppStrings.notifications.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state.readNotificationStatus == Status.loaded) {
            int index = state.notificationList.indexWhere(
                (element) => element.id == state.readNotificationId);
            if (index > -1) {
              var notification =
                  state.notificationList[index].copyWith(status: '1');
              state.notificationList.removeAt(index);
              state.notificationList.insert(index, notification);
              context
                  .read<NotificationBloc>()
                  .add(GetUnReadNotificationEvent());
            }
          } else if (state.deleteNotificationStatus == Status.loading) {
            alertOpen = true;
            HelperFunctions.showPopUpLoadingAlert(context);
          } else if (state.deleteNotificationStatus == Status.loaded) {
            if (alertOpen) {
              alertOpen = false;
              NavigationHelper.pop(context);
              state.notificationList.removeWhere(
                  (element) => element.id == state.deleteNotificationId);
            }
          } else if (state.deleteNotificationStatus == Status.error) {
            if (alertOpen) {
              alertOpen = false;
              NavigationHelper.pop(context);
              HelperFunctions.showSnackBar(context, AppStrings.tryAgain.tr());
            }
          }
        },
        builder: (context, state) => state.notificationStatus == Status.initial
            ? const Center(
                child: LoadingIndicatorWidget(),
              )
            : state.notificationList.isEmpty
                ? Center(
                    child: Lottie.asset('assets/json/empty.json'),
                  )
                : CustomRefreshWrapper(
                    scrollController: scrollController,
                    refreshData: getPageData,
                    onListen: () =>
                        getPageData(start: state.notificationList.length),
                    builder: (context, properties) => CustomScrollView(
                      controller: state.notificationList.length <= 10
                          ? null
                          : scrollController,
                      slivers: <Widget>[
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: CustomPageHeader(
                            child: CustomRefreshWrapper(
                              scrollController: scrollController,
                              refreshData: getPageData,
                              onListen: () => getPageData(
                                  start: state.notificationList.length),
                              builder: (context, properties) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  children: [
                                    Column(
                                      children: List.generate(
                                        state.notificationList.length,
                                        (index) {
                                          var notification =
                                              state.notificationList[index];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 5.h,
                                            ),
                                            child: notification.status == '0'
                                                ? ClipRRect(
                                                    child: Banner(
                                                      message: AppStrings.unRead
                                                          .tr(),
                                                      location: BannerLocation
                                                          .topStart,
                                                      color:
                                                          ColorManager.kBlack,
                                                      child: NotificationItem(
                                                        notification:
                                                            notification,
                                                      ),
                                                    ),
                                                  )
                                                : NotificationItem(
                                                    notification: notification,
                                                  ),
                                          );
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: state.notificationStatus ==
                                          Status.loading,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: ColorManager.primaryLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
