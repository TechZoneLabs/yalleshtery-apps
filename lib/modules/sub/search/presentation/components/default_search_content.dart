import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../widgets/circle_tab_indicator_widget.dart';
import '../widgets/popular_content_widget.dart';
import '../widgets/recent_content_widget.dart';

class DefaultSearchContent extends StatelessWidget {
  final List<String> recentData;
  final void Function(String val) toTempProducts;
  final void Function() onClear;
  const DefaultSearchContent({Key? key, required this.recentData, required this.toTempProducts, required this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: ColorManager.primaryLight,
            unselectedLabelColor: Colors.grey[600],
            indicator: CircleTabIndicator(
              color: ColorManager.primaryLight,
              radius: 5.r,
            ),
            tabs: [
              CustomText(
                AppStrings.popularText.tr(),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                AppStrings.recentText.tr(),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(top: 10.h),
              child: TabBarView(
                children: [
                  PopularContentWidget(
                    toTempProducts: toTempProducts,
                  ),
                  RecentContentWidget(
                    data: recentData,
                    onTapRecent: toTempProducts,
                    onClear:onClear,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
