import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../cart/domain/entities/cart.dart';

class OrderProductItem extends StatelessWidget {
  final CartProduct item;
  const OrderProductItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discountPercent =
        item.lastPrice == null || item.storeAmountsProduct == 0
            ? 0.0
            : (double.parse(item.lastPrice!) - double.parse(item.price)) /
                double.parse(item.lastPrice!) *
                100;
    bool hasOfferAttachment = item.offerData != null &&
        item.lastPrice == null &&
        item.storeAmountsProduct != 0;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorManager.swatch,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 126.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorManager.kWhite,
                ),
              ),
              ImageBuilder(
                height: 126.h,
                width: 90.w,
                radius: 10.r,
                fit: BoxFit.contain,
                image:
                    '${AppConstants.imgUrl.toString()}/products/${item.image}',
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  item.productName,
                ),
                hasOfferAttachment
                    ? HelperFunctions.discountWidget(
                        item.offerData!.attachmentSingle,
                      )
                    : discountPercent > 0.0
                        ? HelperFunctions.discountWidget(
                            discountPercent.toStringAsPrecision(2) +
                                ' % ' +
                                'Discount'.tr(),
                          )
                        : const Padding(
                            padding: EdgeInsets.zero,
                          ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    item.lastPrice != null && item.lastPrice != '0'
                        ? Row(
                            children: [
                              CustomText(
                                item.lastPrice! + ' ' + AppStrings.egp.tr(),
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.lineThrough,
                              ),
                              SizedBox(width: 5.w)
                            ],
                          )
                        : const Padding(
                            padding: EdgeInsets.zero,
                          ),
                    CustomText(
                      item.price + ' ' + AppStrings.egp.tr(),
                      color: item.lastPrice != null && item.lastPrice != '0'
                          ? ColorManager.kRed
                          : ColorManager.primaryLight,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
