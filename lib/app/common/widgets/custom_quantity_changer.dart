import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../modules/main/home/presentation/controller/home_bloc.dart';
import '../../../modules/sub/cart/domain/usecases/update_cart_item_use_case.dart';
import '../../../modules/sub/cart/presentation/controller/cart_bloc.dart';
import '../../../modules/sub/products/presentation/controller/products_bloc.dart';
import '../../helper/helper_functions.dart';
import '../../utils/color_manager.dart';
import 'custom_text.dart';

class CustomQuantityChanger extends StatelessWidget {
  const CustomQuantityChanger({
    Key? key,
    required this.productId,
    required this.quantity,
    required this.minQuantity,
    required this.maxQuantity,
    this.changerBorderColor,
    this.hasLoading = false,
    this.fromCart = false,
    this.fromDetails = false,
    required this.storeAmounts,
    this.size,
  }) : super(key: key);

  final String productId, quantity, minQuantity, maxQuantity;
  final int storeAmounts;
  final Color? changerBorderColor;
  final bool hasLoading, fromCart, fromDetails;
  final double? size;

  @override
  Widget build(BuildContext context) {
    int qty = int.parse(quantity);

    void updateData(int tempQuantity) {
      context.read<CartBloc>().add(
            UpdateItemEvent(
              fromCart: fromCart,
              updateItemParameters: UpdateItemParameters(
                id: productId,
                quantity: tempQuantity,
              ),
            ),
          );
      context.read<ProductsBloc>().add(
            UpdateCustomProductEvent(
              productId: productId,
              quantity: tempQuantity.toString(),
            ),
          );
      context.read<HomeBloc>().add(
            UpdateHomeProducts(
              productId: productId,
              quantity: tempQuantity.toString(),
            ),
          );
      if (fromDetails) {
        context.read<ProductsBloc>().add(
              UpdateProductDetailsEvent(
                productId: productId,
                quantity: tempQuantity.toString(),
              ),
            );
      }
    }

    return StatefulBuilder(
      builder: (context, setState) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (storeAmounts > qty) {
                if (maxQuantity == '' || maxQuantity == '0'
                    ? true
                    : qty < int.parse(maxQuantity)) {
                  int tempQuantity = qty + 1;
                  if (!fromCart) {
                    setState(
                      () => qty = tempQuantity,
                    );
                  }
                  updateData(tempQuantity);
                } else {
                  HelperFunctions.showSnackBar(
                    context,
                    'The quantity of this product'.tr() +
                        ' ' +
                        'should be equal or smaller than'.tr() +
                        ' ' +
                        maxQuantity,
                  );
                }
              } else {
                HelperFunctions.showSnackBar(
                  context,
                  'The quantity of this product'.tr() +
                      ' ' +
                      'should be equal or smaller than'.tr() +
                      ' ' +
                      storeAmounts.toString(),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                border: Border.all(
                  color: changerBorderColor ?? ColorManager.primaryLight,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                'assets/icons/plus.svg',
                height: size,
                width: size,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: hasLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryLight,
                    ),
                  )
                : CustomText(
                    qty.toString(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
          ),
          Visibility(
            visible: qty > 1,
            child: GestureDetector(
              onTap: () {
                if (minQuantity == '' || !fromCart
                    ? true
                    : qty > int.parse(minQuantity)) {
                  int tempQuantity = qty - 1;
                  if (!fromCart) {
                    setState(
                      () => qty = tempQuantity,
                    );
                  }
                  updateData(tempQuantity);
                } else {
                  HelperFunctions.showSnackBar(
                    context,
                    'The quantity of this product'.tr() +
                        ' ' +
                        'should be equal or greater than'.tr() +
                        ' ' +
                        minQuantity,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: changerBorderColor ?? ColorManager.primaryLight,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SvgPicture.asset(
                  'assets/icons/min.svg',
                  height: size,
                  width: size,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
