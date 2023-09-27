import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../sub/address/presentation/controller/address_bloc.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({Key? key}) : super(key: key);

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  bool alertOpen = false;
  late AddressBloc addressBloc = context.read<AddressBloc>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  getPageData({int start = 0}) {
    addressBloc.add(GetAllAddressEvent(start: start));
    if (addressBloc.hasDataSaved) {
      addressBloc.add(ClearSavedData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          AppStrings.shippingAdresses.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
        actions: [
          IconButton(
            onPressed: () => NavigationHelper.pushNamed(
              context,
              Routes.addAddressRoute,
            ),
            icon: SvgPicture.asset('assets/icons/plus.svg'),
          )
        ],
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state.deletedAddressStatus == Status.loading ||
              state.addAddressStatus == Status.loading) {
            alertOpen = true;
            HelperFunctions.showPopUpLoadingAlert(context);
          } else if (state.deletedAddressStatus == Status.error ||
              state.addAddressStatus == Status.error) {
            if (alertOpen) {
              alertOpen = false;
              NavigationHelper.pop(context);
              HelperFunctions.showSnackBar(context, state.msg);
            }
          } else if (state.deletedAddressStatus == Status.loaded) {
            if (alertOpen) {
              alertOpen = false;
              NavigationHelper.pop(context);
              state.allAddresses.removeWhere(
                  (element) => element.id == state.deletedAddressId);
            }
          } else if (state.addAddressStatus == Status.loaded) {
            if (alertOpen) {
              alertOpen = false;
              //pop loading popUp
              NavigationHelper.pop(context);
              //pop add page
              NavigationHelper.pop(context);
              getPageData();
            }
          }
        },
        builder: (context, state) => state.allAddressesStatus == Status.initial
            ? const Center(
                child: LoadingIndicatorWidget(),
              )
            : state.allAddressesStatus == Status.error &&
                    state.allAddresses.isEmpty
                ? Center(
                    child: Lottie.asset('assets/json/empty.json'),
                  )
                : CustomPageHeader(
                    child: CustomRefreshWrapper(
                      scrollController: scrollController,
                      refreshData: getPageData,
                      onListen: () => getPageData(
                        start: state.allAddresses.length,
                      ),
                      builder: (context, properties) => SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(AppStrings.savedAddresses.tr()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state.allAddresses
                                  .map(
                                    (e) => ListTile(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 16.h),
                                      title: CustomText(
                                        '${e.cityName}'
                                        ' , '
                                        '${e.title}',
                                      ),
                                      subtitle: Row(
                                        children: [
                                          CustomText(
                                            AppStrings.buildingNo.tr() +
                                                ' ' +
                                                '${e.buildingNumber}'
                                                    ' , '
                                                    '${e.streetName}',
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () => addressBloc.add(
                                                DeleteAddressEvent(
                                                  addressId: e.id!,
                                                ),
                                              ),
                                              icon: SvgPicture.asset(
                                                'assets/icons/delete.svg',
                                                color: ColorManager.kBlack,
                                              ),
                                            ),
                                          ),
                                          e.isDefault == '1'
                                              ? CustomText(
                                                  AppStrings.kdefault.tr())
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 27.w),
                                                )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            CustomElevatedButton(
                              onPressed: () => NavigationHelper.pushNamed(
                                context,
                                Routes.addAddressRoute,
                              ),
                              priColor: ColorManager.primaryLight,
                              titleColor: ColorManager.kWhite,
                              title: AppStrings.addAdress,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
