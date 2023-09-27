import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../../main/profile/presentation/controller/profile_bloc.dart';
import '../../../address/domain/entities/address.dart';
import '../../../order/domain/usecases/add_order_use_case.dart';
import '../../../order/presentation/controller/order_bloc.dart';
import '../../../order/presentation/widgets/order_summary_widget.dart';
import '../controller/cart_bloc.dart';
import 'success_page.dart';

class SummaryPage extends StatelessWidget {
  final Address selectedAdress;
  final String specialNote;
  const SummaryPage({
    Key? key,
    required this.selectedAdress,
    required this.specialNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    bool hasLoadingAlert = false;
    return Scaffold(
      backgroundColor: ColorManager.background,
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
          AppStrings.orderDetails.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) => CustomPageHeader(
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Delivery details'.tr(),
                          fontSize: 20.sp,
                        ),
                        SizedBox(height: 15.h),
                        CustomText(
                          '${selectedAdress.cityName} , ${selectedAdress.title}',
                        ),
                        CustomText(
                          '${selectedAdress.streetName} , ${selectedAdress.buildingNumber}',
                          color: ColorManager.kGrey,
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) => state.user != null
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        'Receives'.tr(),
                                        color: ColorManager.kGrey,
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomText(
                                        state.user!.userName,
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomText(
                                        'Phone number'.tr(),
                                        color: ColorManager.kGrey,
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomText(
                                        state.user!.mobile,
                                      ),
                                    ],
                                  ),
                                )
                              : const Padding(padding: EdgeInsets.zero),
                        ),
                        const Divider(),
                        SizedBox(height: 15.h),
                        OrderSummaryWidget(
                          itemsNum: cartState.cartNum,
                          totalDiscount: cartState.cart!.totalDiscount,
                          itemPrice: cartState.cart!.totalPrice,
                          deliveryPrice: selectedAdress.deliveryPrice!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocConsumer<OrderBloc, OrderState>(
                listener: (context, orderstate) {
                  if (orderstate.addOrderStatus == Status.loading) {
                    hasLoadingAlert = true;
                    HelperFunctions.showPopUpLoadingAlert(context);
                  } else if (orderstate.addOrderStatus == Status.error) {
                    if (hasLoadingAlert) {
                      hasLoadingAlert = false;
                      NavigationHelper.pop(context);
                      HelperFunctions.showSnackBar(context, orderstate.msg);
                    }
                  } else if (orderstate.addOrderStatus == Status.loaded) {
                    hasLoadingAlert = false;
                    NavigationHelper.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuccessPage(),
                      ),
                      (route) => false,
                    );
                  }
                },
                builder: (context, orderstate) => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: CustomElevatedButton(
                    onPressed: () => context.read<OrderBloc>().add(
                          AddOrderEvent(
                            addOrderParameters: AddOrderParameters(
                              address: selectedAdress,
                              cartId: cartState.cart!.id,
                              note: specialNote,
                              discount: cartState.cart!.totalDiscount,
                              items: cartState.cart!.items,
                            ),
                          ),
                        ),
                    title: 'Confirm Order',
                    priColor: ColorManager.primaryLight,
                    titleColor: ColorManager.kWhite,
                  ),
                ),
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }
}

