import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../domain/entities/cart.dart';
import 'custom_promo_checker.dart';

class CartSummaryWidget extends StatelessWidget {
  final String cartId;
  final Status promoStatus;
  final CouponInfo? couponInfo;
  final int totalProductCount;
  final num totalPrice;
  final String totalDiscount;
  final void Function()? toCheckout, toSummary;

  const CartSummaryWidget({
    Key? key,
    required this.totalPrice,
    required this.totalDiscount,
    required this.totalProductCount,
    required this.couponInfo,
    required this.promoStatus,
    required this.cartId,
    this.toCheckout,
    this.toSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bottomKeyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: ColorManager.kWhite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 2.h,
            child: Divider(
              height: 0,
              color: ColorManager.kGrey,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                CustomPromoChecker(
                  cartId: cartId,
                  promoStatus: promoStatus,
                  couponInfo: couponInfo,
                ),
                bottomKeyboardPadding > 0 
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: bottomKeyboardPadding,
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 25.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    totalProductCount.toString(),
                                    color: ColorManager.primary,
                                  ),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                    AppStrings.items.tr(),
                                    color: ColorManager.primary,
                                  ),
                                ],
                              ),
                              CustomText(
                                totalPrice.toStringAsFixed(2),
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                AppStrings.discounts.tr(),
                                color: ColorManager.primaryLight,
                              ),
                              CustomText(
                                totalDiscount,
                                color: ColorManager.primaryLight,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                AppStrings.subTotal.tr(),
                                color: ColorManager.primary,
                              ),
                              CustomText(
                                (totalPrice -
                                        (double.tryParse(
                                              totalDiscount,
                                            ) ??
                                            0.0))
                                    .toStringAsFixed(2),
                                color: ColorManager.primary,
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),
                          CustomElevatedButton(
                            onPressed:toCheckout??toSummary,
                            title: toCheckout != null
                                ? AppStrings.toCheckout
                                : "Next",
                            priColor: ColorManager.primaryLight,
                            titleColor: ColorManager.kWhite,
                          ),
                          SizedBox(height: 18.h),
                        ],
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
