import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/common/widgets/loading_card.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/widgets/custom_category_item.dart';
import 'custom_tiltle_row.dart';

class HomeCategoriesWidget extends StatelessWidget {
  final Status status;
  final List<Category> data;
  final EdgeInsetsGeometry padding;
  const HomeCategoriesWidget({
    Key? key,
    required this.data,
    required this.status,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notLoading = status == Status.loaded || status == Status.error;
    return Padding(
      padding: notLoading && data.isEmpty ? EdgeInsets.zero : padding,
      child: Column(
        children: [
          Visibility(
            visible: status != Status.error,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: CustomTitleRow(
                title: 'ExploreCategories'.tr(),
                onTap: () => NavigationHelper.pushNamed(
                  context,
                  Routes.categriesRoute,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: IntrinsicHeight(
                child: Row(
                  children: status == Status.initial
                      ? List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: LoadingCard(
                              width: 100.w,
                              height: 70.h,
                            ),
                          ),
                        )
                      : data
                          .map((e) => Container(
                                width: 100.w,
                                padding: context.locale == AppConstants.arabic
                                    ? const EdgeInsets.only(left: 10)
                                    : const EdgeInsets.only(right: 10),
                                child: CustomCategryItem(
                                  width: 100.w,
                                  category: e,
                                ),
                              ))
                          .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
