import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/cart.dart';
import '../../domain/usecases/check_promo_use_case.dart';
import '../controller/cart_bloc.dart';

class CustomPromoChecker extends StatelessWidget {
  final String cartId;
  final Status promoStatus;
  final CouponInfo? couponInfo;
  const CustomPromoChecker({
    Key? key,
    required this.couponInfo,
    required this.promoStatus,
    required this.cartId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = context.read<CartBloc>();
    String promoVal = couponInfo == null ? '' : couponInfo!.code,
        discountValue = couponInfo == null ? '' : couponInfo!.discountValue,
        discountType = couponInfo == null ? '' : couponInfo!.discountType,
        cid = couponInfo == null ? '' : couponInfo!.id;
    String mark = discountType == '\$' ? AppStrings.egp.tr() : '%';
    return StatefulBuilder(
      builder: (context, setState) => promoStatus == Status.loading
          ? const LoadingIndicatorWidget()
          : Column(
              children: [
                Visibility(
                  visible: discountValue.isEmpty,
                  child: CustomText(
                    'Do you have a promo code ?'.tr(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: ColorManager.kGrey),
                  ),
                  child: discountValue.isEmpty
                      ? Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: promoVal,
                                onChanged: (value) => setState(
                                  () => promoVal = value,
                                ),
                                onFieldSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    cartBloc.add(
                                      CheckPromoEvent(
                                        promoParameters: PromoParameters(
                                          cartId: cartId,
                                          promoVal: value,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter promo code here'.tr(),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: promoVal.isEmpty
                                  ? null
                                  : () => cartBloc.add(
                                        CheckPromoEvent(
                                          promoParameters: PromoParameters(
                                            cartId: cartId,
                                            promoVal: promoVal,
                                          ),
                                        ),
                                      ),
                              child: CustomText(
                                'apply-code'.tr(),
                              ),
                            )
                          ],
                        )
                      : ListTile(
                          title: CustomText(
                            'You saved'.tr() + ' ' + discountValue + ' ' + mark,
                          ),
                          subtitle: CustomText('promo'.tr() +
                              ' ' +
                              promoVal +
                              ' ' +
                              'applied'.tr()),
                          trailing: GestureDetector(
                            onTap: () => cartBloc.add(
                              DeletePromoEvent(
                                couponId: cid,
                              ),
                            ),
                            child: const Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
