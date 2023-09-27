import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_dash_line.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';

class OrderSummaryWidget extends StatelessWidget {
  final bool showTitle;
  final String itemsNum, totalDiscount;
  final num itemPrice;
  final String deliveryPrice;

  const OrderSummaryWidget(
      {Key? key,
      required this.itemsNum,
      required this.totalDiscount,
      required this.itemPrice,
      required this.deliveryPrice,
      this.showTitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: showTitle,
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: CustomText(
              'Order summary'.tr(),
              fontSize: 20.sp,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Items quantity'.tr(),
            ),
            CustomText(
              itemsNum + ' ' + AppStrings.items.tr(),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Order amount'.tr(),
            ),
            CustomText(
              itemPrice.toStringAsFixed(2),
            ),
          ],
        ),
        deliveryPrice == ''
            ? const Padding(padding: EdgeInsets.zero)
            : Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Shipping fees'.tr(),
                    ),
                    CustomText(
                      deliveryPrice,
                    ),
                  ],
                ),
              ),
        Visibility(
          visible: totalDiscount.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Discount'.tr(),
                  color: ColorManager.primaryLight,
                ),
                CustomText(
                  totalDiscount,
                  color: ColorManager.primaryLight,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        const DashedHorizontalLine(),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Total'.tr(),
              fontSize: 20.sp,
            ),
            CustomText(
              deliveryPrice == ''
                  ? itemPrice.toStringAsFixed(2)
                  : totalDiscount == ''
                      ? (itemPrice + double.parse(deliveryPrice))
                          .toStringAsFixed(2)
                      : (itemPrice +
                              double.parse(deliveryPrice) -
                              double.parse(totalDiscount))
                          .toStringAsFixed(2),
            ),
          ],
        ),
      ],
    );
  }
}
