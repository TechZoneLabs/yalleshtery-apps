import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:turbo/app/helper/helper_functions.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../../main/home/presentation/controller/home_bloc.dart';
import '../../../cart/domain/usecases/add_item_to_cart_use_case.dart';
import '../../../cart/presentation/controller/cart_bloc.dart';
import '../../../products/presentation/controller/products_bloc.dart';
import '../../domain/entities/order.dart';
import '../controller/order_bloc.dart';
import '../widgets/order_product_item.dart';
import '../widgets/order_summary_widget.dart';
import '../widgets/order_time_line.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  int itemLength = 0;
  bool hasLoading = false;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorManager.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorManager.background,
          leading: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.kBlack,
            ),
            onPressed: () => NavigationHelper.pop(context),
          ),
          centerTitle: true,
          title: CustomText(
            AppStrings.orderDetails.tr(),
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: ColorManager.kBlack,
          ),
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            OrderEntity? order = state.orderDetails;
            return state.getOrderDetailsStatus == Status.loading
                ? const Center(
                    child: LoadingIndicatorWidget(),
                  )
                : state.getOrderDetailsStatus == Status.error
                    ? Center(
                        child: Lottie.asset('assets/json/empty.json'),
                      )
                    : Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomPageHeader(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      'Order Details'.tr(),
                                      fontSize: 20.sp,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      DateFormat(
                                        'yyyy:MM:dd | hh:mm a',
                                        'en',
                                      ).format(
                                        DateTime.parse(order!.dateAdded),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      'order ID'.tr() + ' : ' + order.id,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText('Order status'.tr() + ' : '),
                                    SizedBox(height: 10.h),
                                    OrderTimeLine(
                                      currentStatus: order.status,
                                      statusList: const [
                                        'pending',
                                        'waiting_confirm',
                                        'confirmed',
                                        'under_prepare',
                                        'ready_to_delivered',
                                        'in_delivered',
                                        'delivered',
                                        'canceled'
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              const Divider(),
                              CustomText(
                                'Delivery details'.tr(),
                                fontSize: 20.sp,
                              ),
                              SizedBox(height: 10.h),
                              CustomText(
                                '${order.cityName} , ${order.orderAddress}',
                              ),
                              SizedBox(height: 10.h),
                              const Divider(),
                              CustomText(
                                'Order summary'.tr(),
                                fontSize: 20.sp,
                              ),
                              SizedBox(height: 10.h),
                              Column(
                                children: order.items
                                    .map((e) => Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.h),
                                          child: OrderProductItem(item: e),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(height: 5.h),
                              OrderSummaryWidget(
                                showTitle: false,
                                itemsNum: order.items.length.toString(),
                                totalDiscount: order.discount,
                                itemPrice: num.parse(order.supTotalPrice),
                                deliveryPrice: order.deliveryPrice,
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  // order.status == 'pending'
                                  //     ? Expanded(
                                  //         child: Row(
                                  //           children: [
                                  //             Expanded(
                                  //               child: CustomElevatedButton(
                                  //                 onPressed: () {

                                  //                 },
                                  //                 title: 'Cancel order',
                                  //               ),
                                  //             ),
                                  //             SizedBox(width: 10.w),
                                  //           ],
                                  //         ),
                                  //       )
                                  //     : const Padding(padding: EdgeInsets.zero),
                                  Expanded(
                                    child: BlocConsumer<CartBloc, CartState>(
                                      listener: (context, cartState) {
                                        if (cartState.addItemStatus ==
                                            Status.loading) {
                                          if (!hasLoading) {
                                            hasLoading = true;
                                            HelperFunctions
                                                .showPopUpLoadingAlert(
                                              context,
                                            );
                                          }
                                        } else if (cartState.addItemStatus ==
                                            Status.error) {
                                          if (hasLoading) {
                                            itemLength -= itemLength;
                                            if (itemLength == 0) {
                                              hasLoading = false;
                                              NavigationHelper.pop(context);
                                              HelperFunctions.showSnackBar(
                                                context,
                                                state.msg,
                                              );
                                            }
                                          }
                                        } else if (cartState.addItemStatus ==
                                            Status.loaded) {
                                          if (hasLoading) {
                                            itemLength -= itemLength;
                                            if (itemLength == 0) {
                                              hasLoading = false;
                                              NavigationHelper.pop(context);
                                            }
                                          }
                                        }
                                      },
                                      builder: (context, cartState) {
                                        return CustomElevatedButton(
                                          onPressed: () {
                                            setState(
                                              () => itemLength =
                                                  order.items.length,
                                            );
                                            for (var item in order.items) {
                                              context.read<CartBloc>().add(
                                                    AddItemEvent(
                                                      addItemParameters:
                                                          AddItemParameters(
                                                        productId:
                                                            item.productId,
                                                        quantity: int.parse(
                                                            item.quantity),
                                                        productTypeName: item
                                                            .productTypeName,
                                                        offerId: item.offerId,
                                                      ),
                                                    ),
                                                  );
                                              context.read<ProductsBloc>().add(
                                                    UpdateCustomProductEvent(
                                                      productId: item.productId,
                                                      quantity: item.quantity,
                                                    ),
                                                  );
                                              context.read<HomeBloc>().add(
                                                    UpdateHomeProducts(
                                                      productId: item.productId,
                                                      quantity: item.quantity,
                                                    ),
                                                  );
                                            }
                                          },
                                          title: 'Buy again',
                                          priColor: ColorManager.primaryLight,
                                          titleColor: ColorManager.kWhite,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      );
          },
        ),
      );
}
