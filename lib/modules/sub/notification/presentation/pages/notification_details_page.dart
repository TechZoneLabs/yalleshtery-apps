import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../controller/notification_bloc.dart';

class NotificationDetailsPage extends StatelessWidget {
  const NotificationDetailsPage({Key? key}) : super(key: key);

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
          AppStrings.notificationDetails.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return state.notificationDetailsStatus == Status.loaded
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.notificationDetails!.title),
                      HtmlWidget(
                        state.notificationDetails!.content,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: state.notificationDetailsStatus == Status.loading
                      ? const LoadingIndicatorWidget()
                      : Lottie.asset('assets/json/empty.json'),
                );
        },
      ),
    );
  }
}
