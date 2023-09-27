import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../controller/cart_bloc.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  late CartBloc cartBloc = context.read<CartBloc>();
  @override
  void initState() {
    cartBloc.add(const EmptyCartEvent(withoutEmit: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/order-pass.png',
                        ),
                        CustomText(
                          'Order added sucessfully'.tr(),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        CustomText(
                          'Your order will be delivered soon. It can be tracked in the My orders'
                              .tr(),
                          color: ColorManager.kGrey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomElevatedButton(
                onPressed: () => NavigationHelper.pushNamed(
                  context,
                  Routes.ordersRoute,
                ),
                title: 'My Orders',
                priColor: ColorManager.primaryLight,
                titleColor: ColorManager.kWhite,
              ),
              SizedBox(height: 15.h),
              CustomElevatedButton(
                onPressed: () => NavigationHelper.pushNamedAndRemoveUntil(
                  context,
                  Routes.togglePagesRoute,
                  (route) => false,
                ),
                title: 'Continue Shopping',
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
