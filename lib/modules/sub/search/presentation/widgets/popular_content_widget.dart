import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/utils/strings_manager.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../control/presentation/controller/control_bloc.dart';
import '../../../../main/brands/domain/entities/trademark.dart';
import '../../../../main/brands/presentation/widgets/custom_trademark_item.dart';

class PopularContentWidget extends StatelessWidget {
  final void Function(String commonVal) toTempProducts;
  const PopularContentWidget({Key? key, required this.toTempProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlBloc, ControlState>(
      builder: (context, state) {
        return state.controlStatus == Status.loaded
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(AppStrings.searchKeywords.tr()),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: state.contactInfo!.allCommonSearchWords
                          .map(
                            (e) => GestureDetector(
                              onTap: () => toTempProducts(e),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.primaryLight,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: CustomText(e),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 20.h),
                    CustomText(AppStrings.brands.tr()),
                    SizedBox(height: 15.h),
                    Wrap(
                      spacing: 10.w,
                      children: state.contactInfo!.allCommonTrademarks
                          .map(
                            (e) => CustomTradeMarkItem(
                              width: ScreenUtil().screenWidth / 5,
                              trademark: Trademark(
                                id: e.trademarkId,
                                title: e.title,
                                image: e.image,
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              )
            : Center(
                child: CustomText(
                  'There are no popular searches'.tr(),
                ),
              );
      },
    );
  }
}
