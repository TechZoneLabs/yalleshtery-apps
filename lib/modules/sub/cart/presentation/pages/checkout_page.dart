import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../../main/profile/presentation/controller/profile_bloc.dart';
import '../../../address/domain/entities/address.dart';
import '../../../address/presentation/controller/address_bloc.dart';
import '../controller/cart_bloc.dart';
import '../widgets/cart_summary_widget.dart';
import 'summary_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  ScrollController scrollController = ScrollController();
  TextEditingController noteController = TextEditingController();
  late AddressBloc addressBloc = context.read<AddressBloc>();
  Address? selectedAdress;
  bool alertOpen = false;
  @override
  void initState() {
    getAddressData();
    context.read<ProfileBloc>().add(GetUserDataEvent());
    super.initState();
  }

  getAddressData() => addressBloc.add(const GetAllAddressEvent());
  @override
  Widget build(BuildContext context) => Scaffold(
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
            AppStrings.checkout.tr(),
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: ColorManager.kBlack,
          ),
        ),
        body: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, addressState) {
            if (addressState.addAddressStatus == Status.loading) {
              alertOpen = true;
              HelperFunctions.showPopUpLoadingAlert(context);
            } else if (addressState.addAddressStatus == Status.error) {
              if (alertOpen) {
                alertOpen = false;
                NavigationHelper.pop(context);
                HelperFunctions.showSnackBar(context, addressState.msg);
              }
            } else if (addressState.addAddressStatus == Status.loaded) {
              if (alertOpen) {
                alertOpen = false;
                //pop loading popUp
                NavigationHelper.pop(context);
                //pop add page
                NavigationHelper.pop(context);
                getAddressData();
              }
            } else if (addressState.allAddressesStatus == Status.loaded) {
              if (addressBloc.hasDataSaved) {
                selectedAdress = addressState.allAddresses.first;
                addressBloc.add(ClearSavedData());
              } else {
                selectedAdress ??= addressState.allAddresses.firstWhere(
                  (element) => element.isDefault == '1',
                  orElse: () => addressState.allAddresses.first,
                );
              }
            }
          },
          builder: (context, addressState) {
            return addressState.allAddressesStatus == Status.initial
                ? const Center(
                    child: LoadingIndicatorWidget(),
                  )
                : CustomPageHeader(
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
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: CustomText(
                                      AppStrings.shippingAdresses.tr(),
                                    ),
                                  ),
                                  addressState.allAddresses.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 16.h),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<Address>(
                                              hint: CustomText(
                                                AppStrings.selectAddress.tr(),
                                                color: ColorManager.kBlack,
                                              ),
                                              buttonDecoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                border: Border.all(
                                                  color: ColorManager.border,
                                                  width: 0.5,
                                                ),
                                              ),
                                              dropdownElevation: 5,
                                              dropdownMaxHeight: 0.5.sh,
                                              dropdownDecoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(8.r),
                                                  bottomRight:
                                                      Radius.circular(8.r),
                                                ),
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: SvgPicture.asset(
                                                    'assets/icons/drop-down.svg'),
                                              ),
                                              iconSize: 26,
                                              isExpanded: true,
                                              scrollbarAlwaysShow: true,
                                              value: selectedAdress,
                                              items: addressState.allAddresses
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: CustomText(
                                                        '${e.countryName} , ${e.cityName} , ${e.title}',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.sp,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) => setState(
                                                () => selectedAdress = value,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Padding(padding: EdgeInsets.zero),
                                  SizedBox(height: 16.h),
                                  CustomElevatedButton(
                                    onPressed: () => NavigationHelper.pushNamed(
                                      context,
                                      Routes.addAddressRoute,
                                    ),
                                    getTitleWidth: true,
                                    title: 'Add new address',
                                    priColor: ColorManager.primaryLight,
                                    titleColor: ColorManager.kWhite,
                                  ),
                                  SizedBox(height: 16.h),
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: CustomText(
                                      'Special note'.tr(),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  TextFormField(
                                    controller: noteController,
                                    maxLines: 2,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(fontSize: 20.sp),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        // borderSide: const BorderSide(
                                        //     color:
                                        //         Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      hintText: 'Write your notes here'.tr(),
                                      hintStyle: TextStyle(
                                        fontSize: 18.sp,
                                        color: ColorManager.kGrey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, cartState) {
                            String cartId = cartState.cart == null
                                ? '0'
                                : cartState.cart!.id;
                            int totalProductCount = cartState.cart == null
                                ? 0
                                : cartState.cart!.totalProductCount;
                            num totalPrice = cartState.cart == null
                                ? 0
                                : cartState.cart!.totalPrice;
                            String totalDiscount = cartState.cart == null
                                ? '0.0'
                                : cartState.cart!.totalDiscount;
                            return CartSummaryWidget(
                              totalProductCount: totalProductCount,
                              totalPrice: totalPrice,
                              totalDiscount: totalDiscount,
                              couponInfo: cartState.couponInfo,
                              promoStatus: cartState.promoStatus,
                              cartId: cartId,
                              toSummary: () {
                                if (selectedAdress != null) {
                                  NavigationHelper.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SummaryPage(
                                        selectedAdress: selectedAdress!,
                                        specialNote: noteController.text,
                                      ),
                                    ),
                                  );
                                } else {
                                  HelperFunctions.showSnackBar(
                                    context,
                                    'Add new address'.tr(),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
          },
        ),
      );
}
