import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/domain/usecases/get_product_details_use_case.dart';
import '../../../products/presentation/controller/products_bloc.dart';
import '../../domain/entities/product_auto_complete.dart';
import '../widgets/searched_product_widget.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  bool hasOnePass = false;
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    bool arabic = context.locale == AppConstants.arabic;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: 0,
        leading: const CloseButton(),
        centerTitle: true,
        title: CustomText(
          AppStrings.scanBarcode.tr(),
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: () => cameraController.toggleTorch(),
            icon: SvgPicture.asset('assets/icons/flash.svg'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            color: ColorManager.primary,
          ),
          Positioned(
            top: 150.h,
            right: 20.w,
            left: 20.w,
            child: SizedBox(
              height: 200.h,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: MobileScanner(
                    fit: BoxFit.cover,
                    controller: cameraController,
                    allowDuplicates: false,
                    onDetect: (capture, _) {
                      if (!hasOnePass) {
                        if (capture.rawValue != null) {
                          setState(() => hasOnePass = true);
                          context.read<ProductsBloc>().add(
                                GetProductDetailsEvent(
                                  productDetailsParmeters:
                                      ProductDetailsParmeters(
                                    productBarcode: capture.rawValue,
                                  ),
                                ),
                              );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: BlocConsumer<ProductsBloc, ProductsState>(
                listener: (context, state) {
                  if (state.productDetailsStatus == Status.error) {
                    Future.delayed(
                      const Duration(seconds: 3),
                      () => setState(
                        () => hasOnePass = false,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  Product? product = state.productDetails;
                  return SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    child: !hasOnePass
                        ? Column(
                            children: [
                              Image.asset('assets/images/barcode.png'),
                              SizedBox(height: 20.h),
                              CustomText(AppStrings.barcodeTitle.tr()),
                              CustomText(
                                AppStrings.barcodeDesc.tr(),
                                textAlign: TextAlign.center,
                                color: ColorManager.kGrey,
                                fontSize: 14.sp,
                              )
                            ],
                          )
                        : state.productDetailsStatus == Status.loading
                            ? Lottie.asset(
                                'assets/json/search.json',
                                height: 0.3.sh,
                                width: 0.3.w,
                              )
                            : state.productDetailsStatus == Status.error
                                ? Lottie.asset(
                                    'assets/json/empty.json',
                                    height: 0.3.sh,
                                    width: 0.3.w,
                                  )
                                : Stack(
                                    children: [
                                      SearchedProductWidget(
                                        product: ProductAutoComplete(
                                          id: product!.id,
                                          name: product.name,
                                          price: product.price,
                                          image: product.images.isNotEmpty
                                              ? product.images.first.name
                                              : product.image,
                                          storeAmounts: product.storeAmounts,
                                        ),
                                        toProductDetails: (_) =>
                                            NavigationHelper.pushNamed(
                                          context,
                                          Routes.productDetailsRoute,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 15.h,
                                        left: arabic ? 10.w : null,
                                        right: arabic ? null : 10.w,
                                        child: GestureDetector(
                                          onTap: () => setState(
                                            () => hasOnePass = false,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                              color: ColorManager.primaryLight,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10.r,
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/delete.svg',
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
