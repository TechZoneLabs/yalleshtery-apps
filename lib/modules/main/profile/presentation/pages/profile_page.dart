import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../sub/cart/presentation/controller/cart_bloc.dart';
import '../../../../sub/notification/presentation/controller/notification_bloc.dart';
import '../controller/profile_bloc.dart';
import '../widgets/profile_body.dart';
import '../widgets/profile_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  bool alertOpen = false;
  bool isGuest = sl<AppShared>().getVal(AppConstants.userTokenKey) == '0';
  late ProfileBloc profileBloc = context.read<ProfileBloc>();
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  getPageData() {
    if (!isGuest) {
      profileBloc.add(GetUserDataEvent());
    }
    profileBloc.add(GetPagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.userStatus == Status.loading) {
          //when profile update loading
          alertOpen = true;
          HelperFunctions.showPopUpLoadingAlert(context);
        } else if (state.userStatus == Status.error) {
          if (alertOpen) {
            //when profile update failed
            alertOpen = false;
            NavigationHelper.pop(context);
            HelperFunctions.showSnackBar(context, state.msg);
          }
        } else if (state.userStatus == Status.loaded) {
          if (alertOpen) {
            //when profile update passed
            alertOpen = false;
            NavigationHelper.pop(context);
            HelperFunctions.showSnackBar(
              context,
              AppStrings.operationPassed.tr(),
            );
          }
        }
      },
      builder: (context, state) {
        return state.userStatus == Status.loaded ||
                state.userStatus == Status.error ||
                isGuest &&
                    (state.pagesStatus == Status.loaded ||
                        state.pagesStatus == Status.error)
            ? CustomPageHeader(
                child: RefreshIndicator(
                  color: ColorManager.primaryLight,
                  backgroundColor: ColorManager.background,
                  onRefresh: () {
                    getPageData();
                    context.read<NotificationBloc>().add(
                          GetUnReadNotificationEvent(),
                        );
                    context.read<CartBloc>().add(
                          const GetCartDataEvent(
                            forceRest: true,
                          ),
                        );
                    return Future.value();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            children: [
                              ProfileHeader(isGest: isGuest, user: state.user),
                              SizedBox(height: 15.h),
                              Divider(color: ColorManager.kGrey),
                              Expanded(
                                child: ProfileBody(
                                  isGest: isGuest,
                                  pageList: state.pages,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const Center(child: LoadingIndicatorWidget());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
