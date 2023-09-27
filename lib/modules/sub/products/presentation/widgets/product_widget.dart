import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/common/widgets/custom_quantity_changer.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/home/presentation/controller/home_bloc.dart';
import '../../../cart/domain/usecases/add_item_to_cart_use_case.dart';
import '../../../cart/presentation/controller/cart_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_details_use_case.dart';
import '../controller/products_bloc.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final bool fromFavoutites;
  const ProductWidget(
      {Key? key, required this.product, this.fromFavoutites = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuest = sl<AppShared>().getVal(AppConstants.userTokenKey) == '0';
    double discountPercent = product.lastPrice == null ||
            product.storeAmounts == 0 ||
            product.price == '0'
        ? 0.0
        : (double.parse(product.lastPrice!) - double.parse(product.price)) /
            double.parse(product.lastPrice!) *
            100;
    bool hasOfferAttachment = product.offeData != null &&
        product.lastPrice == null &&
        product.storeAmounts != 0 &&
        product.price != '0';
    bool hasAttachment = product.attachmentName.isNotEmpty &&
        product.storeAmounts != 0 &&
        product.price != '0';
    void toProductDetails() {
      context.read<ProductsBloc>().add(
            GetProductDetailsEvent(
              productDetailsParmeters: ProductDetailsParmeters(
                productId: product.id,
              ),
            ),
          );
      NavigationHelper.pushNamed(
        context,
        Routes.productDetailsRoute,
      );
    }

    return isGuest
        ? Container(
            width: 155.w,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: ColorManager.swatch,
            ),
            child: GestureDetector(
              onTap: toProductDetails,
              child: Column(
                children: [
                  Container(
                    width: 135.w,
                    decoration: BoxDecoration(
                      color: ColorManager.kWhite,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ImageBuilder(
                      height: 140.h,
                      radius: 10.r,
                      fit: BoxFit.contain,
                      image:
                          '${AppConstants.imgUrl.toString()}/products/${product.image}',
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    product.name,
                    maxLines: 2,
                    fontSize: 14.sp,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.primary,
                  ),
                ],
              ),
            ),
          )
        : Container(
            width: 155.w,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: ColorManager.swatch,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: toProductDetails,
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 135.w,
                              decoration: BoxDecoration(
                                color: ColorManager.kWhite,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: ImageBuilder(
                                height: 140.h,
                                radius: 10.r,
                                fit: BoxFit.contain,
                                image:
                                    '${AppConstants.imgUrl.toString()}/products/${product.image}',
                              ),
                            ),
                            hasAttachment
                                ? Positioned(
                                    top: 8.h,
                                    right: 12.w,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorManager.attachment,
                                          borderRadius:
                                              BorderRadius.circular(4.r)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 5),
                                      child: CustomText(
                                        product.attachmentName,
                                        color: ColorManager.kWhite,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  )
                                : const Padding(padding: EdgeInsets.zero),
                            hasOfferAttachment
                                ? Positioned(
                                    bottom: 0,
                                    right: 5.w,
                                    left: 5.w,
                                    child: HelperFunctions.discountWidget(
                                      product.offeData!.attachmentSingle,
                                    ),
                                  )
                                : discountPercent > 0.0
                                    ? Positioned(
                                        bottom: 0,
                                        right: 5.w,
                                        left: 5.w,
                                        child: HelperFunctions.discountWidget(
                                          discountPercent
                                                  .toStringAsPrecision(2) +
                                              ' % ' +
                                              'Discount'.tr(),
                                        ),
                                      )
                                    : const Padding(padding: EdgeInsets.zero),
                            fromFavoutites
                                ? BlocBuilder<ProductsBloc, ProductsState>(
                                    builder: (context, state) {
                                      return Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorManager.kWhite,
                                            border: Border.all(
                                                color: ColorManager.kGrey
                                                    .withOpacity(0.3)),
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              state.customProds.remove(product);
                                              HelperFunctions.unFavourite(
                                                productId: product.id,
                                              );
                                            },
                                            padding: EdgeInsets.zero,
                                            icon: SvgPicture.asset(
                                              'assets/icons/delete.svg',
                                              color: ColorManager.kRed,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Padding(padding: EdgeInsets.zero),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomText(
                        product.name,
                        maxLines: 2,
                        fontSize: 14.sp,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.primary,
                      ),
                      Row(
                        children: [
                          product.lastPrice != null
                              ? Row(
                                children: [
                                  CustomText(
                                    product.lastPrice! + ' ' + 'EGP'.tr(),
                                    fontFamily: 'Roboto',
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(width: 10.w),
                                ],
                              )
                              : const Padding(padding: EdgeInsets.zero),
                          Expanded(
                            child: Opacity(
                              opacity: product.price != '0' &&
                                      product.storeAmounts > 0
                                  ? 1
                                  : 0,
                              child: CustomText(
                                product.price + ' ' + 'EGP'.tr(),
                                color: product.lastPrice != null
                                    ? ColorManager.kRed
                                    : ColorManager.primary,
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                product.storeAmounts == 0 || product.price == '0'
                    ? SizedBox(
                        width: 1.sw,
                        child: ElevatedButton(
                          onPressed: null,
                          child: CustomText(
                            product.storeAmounts > 0
                                ? 'Soon'.tr()
                                : 'Out of stock'.tr(),
                            color: ColorManager.kWhite,
                            maxLines: 1,
                            fontSize: 14.sp,
                            softWrap: true,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                            ),
                            backgroundColor: ColorManager.primaryLight,
                            disabledBackgroundColor: product.storeAmounts == 0
                                ? ColorManager.kGrey
                                : ColorManager.kOrange,
                          ),
                        ),
                      )
                    : product.quantityInCart != '0'
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: CustomQuantityChanger(
                              productId: product.id,
                              quantity: product.quantityInCart,
                              minQuantity: product.minQuantity,
                              maxQuantity: product.maxQuantity,
                              storeAmounts: product.storeAmounts,
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7.w,
                              ),
                              backgroundColor: ColorManager.primaryLight,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    AppStrings.addToCart.tr(),
                                    maxLines: 1,
                                    fontSize: 14.sp,
                                    softWrap: true,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.kWhite,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Image.asset(
                                  'assets/images/add-to-cart.png',
                                  height: 22,
                                  width: 22,
                                  color: ColorManager.kWhite,
                                )
                              ],
                            ),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                    AddItemEvent(
                                      addItemParameters: AddItemParameters(
                                        productId: product.id,
                                        quantity: 1,
                                        productTypeName:
                                            product.stores.isNotEmpty
                                                ? product.stores.first.name
                                                : '',
                                        offerId: product.offerId ?? '',
                                      ),
                                    ),
                                  );
                              context.read<ProductsBloc>().add(
                                    UpdateCustomProductEvent(
                                      productId: product.id,
                                      quantity: '1',
                                    ),
                                  );
                              context.read<HomeBloc>().add(
                                    UpdateHomeProducts(
                                      productId: product.id,
                                      quantity: '1',
                                    ),
                                  );
                            },
                          )
              ],
            ),
          );
  }
}
