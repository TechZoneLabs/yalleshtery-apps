import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../control/domain/entities/contact_info.dart';
import '../../../../control/presentation/controller/control_bloc.dart';
import '../../../../main/home/presentation/controller/home_bloc.dart';
import '../../../products/presentation/controller/products_bloc.dart';
import '../../domain/entities/cart.dart';
import '../controller/cart_bloc.dart';
import '../widgets/cart_product_item_widget.dart';
import '../widgets/cart_summary_widget.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartBloc cartBloc = context.read<CartBloc>();
  bool showDeleteCart = false;
  bool hasLoadingAlert = false;
  Cart? cart;
  List<CartProduct> items = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  void getPageData({bool update = false, bool forceRest = false}) =>
      cartBloc.add(GetCartDataEvent(
        update: update,
        forceRest: forceRest,
      ));
  @override
  Widget build(BuildContext context) {
    ContactInfo? contactInfo = sl<ControlBloc>().contactInfo;
    
    return Scaffold(
      backgroundColor: ColorManager.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.background,
        centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 25,
          icon: Icon(Icons.arrow_back, color: ColorManager.kBlack),
          onPressed: () => NavigationHelper.pop(context),
        ),
        title: CustomText(
          AppStrings.cart.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
        actions: [
          Visibility(
            visible: showDeleteCart,
            child: IconButton(
              onPressed: () => cartBloc.add(const EmptyCartEvent()),
              padding: EdgeInsets.zero,
              splashRadius: 25,
              icon: SvgPicture.asset(
                'assets/icons/delete.svg',
                color: ColorManager.kBlack,
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.cartStatus == Status.loaded ||
              state.cartStatus == Status.updated) {
            if (hasLoadingAlert) {
              hasLoadingAlert = false;
              NavigationHelper.pop(context);
            }
            setState(() {
              showDeleteCart = true;
              cart = state.cart;
              items = cart!.items;
            });
          } else if (state.cartStatus == Status.error) {
            if (hasLoadingAlert) {
              hasLoadingAlert = false;
              NavigationHelper.pop(context);
            }
            setState(() {
              showDeleteCart = false;
            });
          } else if (state.emptyCartStatus == Status.loading ||
              state.deleteItemStatus == Status.loading) {
            hasLoadingAlert = true;
            HelperFunctions.showPopUpLoadingAlert(context);
          } else if (state.emptyCartStatus == Status.error ||
              state.deleteItemStatus == Status.error) {
            if (hasLoadingAlert) {
              hasLoadingAlert = false;
              NavigationHelper.pop(context);
              HelperFunctions.showSnackBar(context, state.msg);
            }
          } else if (state.emptyCartStatus == Status.loaded ||
              state.deleteItemStatus == Status.loaded) {
            getPageData(
              update: state.deleteItemStatus == Status.loaded,
              forceRest: state.emptyCartStatus == Status.loaded,
            );
            context.read<ProductsBloc>().add(
                  UpdateCustomProductEvent(
                    productId: state.deleteItemProdId,
                    quantity: '0',
                    forceRest: state.emptyCartStatus == Status.loaded,
                  ),
                );
            context.read<HomeBloc>().add(
                  UpdateHomeProducts(
                    productId: state.deleteItemProdId,
                    quantity: '0',
                    forceRest: state.emptyCartStatus == Status.loaded,
                  ),
                );
          } else if (state.promoStatus == Status.loaded) {
            getPageData(update: true);
          } else if (state.promoStatus == Status.error) {
            HelperFunctions.showSnackBar(context, state.msg);
          }
        },
        builder: (context, state) {
          String cartId = cart == null ? '0' : cart!.id;
          int totalProductCount = cart == null ? 0 : cart!.totalProductCount;
          num totalPrice = cart == null ? 0 : cart!.totalPrice;
          String totalDiscount = cart == null ? '0.0' : cart!.totalDiscount;
          return state.cartStatus == Status.loading ||
                  state.cartStatus == Status.error
              ? Center(
                  child: state.cartStatus == Status.error
                      ? Lottie.asset('assets/json/cart.json')
                      : const LoadingIndicatorWidget(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        color: ColorManager.primaryLight,
                        backgroundColor: ColorManager.background,
                        onRefresh: () {
                          getPageData();
                          return Future.value();
                        },
                        child: Scrollbar(
                          controller: scrollController,
                          thumbVisibility: true,
                          child: ListView.separated(
                            controller: scrollController,
                            padding: EdgeInsets.only(
                              bottom: 10.h,
                              right: 15.w,
                              left: 15.w,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) =>
                                items[index].storeAmountsProduct == 0
                                    ? ClipRRect(
                                        child: Banner(
                                          message: AppStrings.outOfStock.tr(),
                                          location: BannerLocation.topStart,
                                          color: ColorManager.kBlack,
                                          child: CartProductItemWidget(
                                            item: items[index],
                                            itemsLength: items.length,
                                          ),
                                        ),
                                      )
                                    : CartProductItemWidget(
                                        item: items[index],
                                        itemsLength: items.length,
                                      ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 16.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CartSummaryWidget(
                      totalProductCount: totalProductCount,
                      totalPrice: totalPrice,
                      totalDiscount: totalDiscount,
                      couponInfo: state.couponInfo,
                      promoStatus: state.promoStatus,
                      cartId: cartId,
                      toCheckout: () {
                        if (contactInfo == null
                            ? true
                            : totalPrice >=
                                double.parse(contactInfo.minOrderPrice)) {
                          String msg = '';
                          for (var element in items) {
                            int index = items.indexOf(element);
                            if (element.maxQuantity.isNotEmpty &&
                                element.maxQuantity != '0') {
                              if (int.parse(element.maxQuantity) <
                                  int.parse(element.quantity)) {
                                msg = 'The quantity of product number'.tr() +
                                    ' ${index + 1} ' +
                                    'should be equal or smaller than'.tr() +
                                    ' ${element.maxQuantity}';
                                break;
                              }
                            } else if (element.minQuantity.isNotEmpty &&
                                element.minQuantity != '0') {
                              if (int.parse(element.minQuantity) >
                                  int.parse(element.quantity)) {
                                msg = 'The quantity of product number'.tr() +
                                    ' ${index + 1} ' +
                                    'should be equal or greater than'.tr() +
                                    ' ${element.maxQuantity}';

                                break;
                              }
                            }
                          }
                          msg.isEmpty
                              ? NavigationHelper.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CheckoutPage(),
                                  ),
                                )
                              : HelperFunctions.showSnackBar(
                                  context,
                                  msg,
                                );
                        } else {
                          HelperFunctions.showSnackBar(
                            context,
                            'The total price should be equal or greater than'
                                    .tr() +
                                ' ${contactInfo.minOrderPrice}',
                          );
                        }
                      },
                    )
                  ],
                );
        },
      ),
    );
  }
}
