import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../app/common/widgets/custom_page_header.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../domain/entities/page.dart';
import '../controller/profile_bloc.dart';

class TempProfilePage extends StatelessWidget {
  final PageEntity page;
  const TempProfilePage({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          page.title,
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.pageDetailsStatus == Status.loaded
              ? CustomPageHeader(
                child: SingleChildScrollView(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  child: HtmlWidget(
                    state.pageDetails!.description,
                  ),
                ),
              )
              : Center(
                  child: state.pageDetailsStatus == Status.error
                      ? SvgPicture.asset('assets/json/empty.json')
                      : const LoadingIndicatorWidget(),
                );
        },
      ),
    );
  }
}
