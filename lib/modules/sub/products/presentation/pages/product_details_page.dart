import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_version_checker/store_version_checker.dart';
import '../../../../../app/common/widgets/custom_copyable_widget.dart';
import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_quantity_changer.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../../main/home/presentation/controller/home_bloc.dart';
import '../../../cart/domain/usecases/add_item_to_cart_use_case.dart';
import '../../../cart/presentation/controller/cart_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_listen_to_product_use_case.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';
import '../controller/products_bloc.dart';
import '../widgets/custom_product_listen_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuest = sl<AppShared>().getVal(AppConstants.userTokenKey) == '0';
    int currentPage = 0;
    bool arabic = context.locale == AppConstants.arabic;
    late Product product;
    late bool hasOneImage;
    bool? isFavourite;
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state.productDetailsStatus == Status.loaded ||
            state.productDetailsStatus == Status.updated) {
          product = state.productDetails!;
          if (state.productDetailsStatus == Status.loaded) {
            hasOneImage = product.images.length == 1;
            isFavourite = HelperFunctions.productIsFavourite(
              productId: product.id,
            );
          }
        }
      },
      buildWhen: (previous, current) =>
          previous.productDetailsStatus == Status.loading ||
          previous.productDetailsStatus == Status.updating,
      builder: (context, state) {
        if (state.productDetailsStatus == Status.loaded &&
            isFavourite == null) {
          product = state.productDetails!;
          hasOneImage = product.images.length == 1;
          isFavourite = HelperFunctions.productIsFavourite(
            productId: product.id,
          );
        }
        return state.productDetailsStatus == Status.loading
            ? const Material(
                child: Center(
                  child: LoadingIndicatorWidget(),
                ),
              )
            : Scaffold(
                backgroundColor: ColorManager.background,
                appBar: AppBar(
                  backgroundColor: ColorManager.background,
                  elevation: 0,
                  leading: IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 25,
                    icon: Icon(Icons.arrow_back, color: ColorManager.kBlack),
                    onPressed: () => NavigationHelper.pop(context),
                  ),
                  actions: state.productDetailsStatus == Status.error
                      ? []
                      : [
                          Visibility(
                            visible: !isGuest,
                            child: StatefulBuilder(
                              builder: (context, favState) => IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 25,
                                icon: SvgPicture.asset(
                                  'assets/icons/fav-prod.svg',
                                  color:
                                      isFavourite! ? ColorManager.kRed : null,
                                ),
                                onPressed: () {
                                  isFavourite!
                                      ? HelperFunctions.unFavourite(
                                          productId: product.id,
                                        )
                                      : HelperFunctions.setFavourite(
                                          productId: product.id,
                                        );
                                  favState(() => isFavourite = !isFavourite!);
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 25,
                            icon:
                                SvgPicture.asset('assets/icons/share-prod.svg'),
                            onPressed: () async {
                              final StoreCheckerResult status =
                                  await StoreVersionChecker().checkUpdate();
                              if (status.appURL != null) {
                                Share.share(status.appURL!);
                              } else {
                                HelperFunctions.showSnackBar(
                                  context,
                                  AppStrings.tryAgain.tr(),
                                );
                              }
                            },
                          ),
                        ],
                ),
                body: state.productDetailsStatus == Status.error
                    ? Center(child: Lottie.asset('assets/json/empty.json'))
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  StatefulBuilder(
                                    builder: (context, imageState) =>
                                        CustomPageHeader(
                                      height: 240.h,
                                      child: CarouselSlider(
                                        items: product.images
                                            .map(
                                              (e) => Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 15.w,
                                                        ),
                                                        width: ScreenUtil()
                                                            .screenWidth,
                                                        height: 200.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorManager
                                                              .kWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.h),
                                                          child: ImageBuilder(
                                                            height: 180.h,
                                                            radius: 10.r,
                                                            image:
                                                                '${AppConstants.imgUrl.toString()}/products/${e.name}',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Visibility(
                                                    visible: !hasOneImage,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: List.generate(
                                                        product.images.length,
                                                        (x) =>
                                                            AnimatedContainer(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          height: 6,
                                                          width: 6,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: currentPage >=
                                                                    x
                                                                ? ColorManager
                                                                    .kBlack
                                                                : Colors.grey
                                                                    .withOpacity(
                                                                        0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                            .toList(),
                                        options: CarouselOptions(
                                          height: 220.h,
                                          aspectRatio: 16 / 9,
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          enableInfiniteScroll:
                                              hasOneImage ? false : true,
                                          reverse: false,
                                          autoPlay: false,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 800),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                          enlargeFactor: 0.3,
                                          onPageChanged: (val, _) => imageState(
                                            () => currentPage = val,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  product.offeData != null
                                      ? SizedBox(
                                          width: 1.sw,
                                          child: HelperFunctions.discountWidget(
                                            product.offeData!.attachmentSingle,
                                          ),
                                        )
                                      : const Padding(padding: EdgeInsets.zero),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(product.name),
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color:
                                                      ColorManager.primaryLight,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    NavigationHelper.pushNamed(
                                                  context,
                                                  Routes.tempProductsRoute,
                                                  arguments: {
                                                    'title':
                                                        product.trademarkTitle,
                                                    'productsParmeters':
                                                        ProductsParmeters(
                                                      searchTrademarkId:
                                                          product.trademarkId,
                                                    )
                                                  },
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: ImageBuilder(
                                                    image:
                                                        '${AppConstants.imgUrl.toString()}/trademarks/${product.trademarkImage}',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          children: [
                                            CustomText(
                                              AppStrings.prodCode.tr() +
                                                  ' : ' +
                                                  product.productCode,
                                              fontSize: 15.sp,
                                              color: ColorManager.kGrey,
                                            ),
                                            SizedBox(width: 15.w),
                                            CustomText(
                                              AppStrings.barcode.tr() +
                                                  ' : ' +
                                                  product.productBarcode,
                                              fontSize: 15.sp,
                                              color: ColorManager.kGrey,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        isGuest
                                            ? const Padding(
                                                padding: EdgeInsets.zero)
                                            : product.storeAmounts == 0
                                                ? Visibility(
                                                    visible: product
                                                        .attachmentName
                                                        .isNotEmpty,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10.h),
                                                      child: CustomText(
                                                        product.attachmentName,
                                                        color: ColorManager
                                                            .primaryLight,
                                                        fontSize: 20.sp,
                                                      ),
                                                    ),
                                                  )
                                                : Builder(builder: (context) {
                                                    double discountPercent = product
                                                                    .lastPrice ==
                                                                null ||
                                                            product.storeAmounts ==
                                                                0 ||
                                                            product.price == '0'
                                                        ? 0.0
                                                        : (double.parse(product
                                                                    .lastPrice!) -
                                                                double.parse(
                                                                    product
                                                                        .price)) /
                                                            double.parse(product
                                                                .lastPrice!) *
                                                            100;
                                                    return Row(
                                                      children: [
                                                        Visibility(
                                                          visible: product
                                                                      .lastPrice !=
                                                                  null &&
                                                              product.lastPrice !=
                                                                  '0',
                                                          child: Padding(
                                                            padding: arabic
                                                                ? EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.w)
                                                                : EdgeInsets
                                                                    .only(
                                                                        right: 8
                                                                            .w),
                                                            child: CustomText(
                                                              (product.lastPrice ??
                                                                      '') +
                                                                  ' ' +
                                                                  'EGP'.tr(),
                                                              fontFamily:
                                                                  'Roboto',
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              product.price !=
                                                                  '0',
                                                          child: CustomText(
                                                            product.price +
                                                                ' ' +
                                                                'EGP'.tr(),
                                                            color: product
                                                                        .lastPrice !=
                                                                    null
                                                                ? ColorManager
                                                                    .kRed
                                                                : null,
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              discountPercent !=
                                                                  0.0,
                                                          child: Padding(
                                                            padding: arabic
                                                                ? EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8.w)
                                                                : EdgeInsets
                                                                    .only(
                                                                        left: 8
                                                                            .w),
                                                            child: HelperFunctions
                                                                .discountWidget(discountPercent
                                                                        .toStringAsPrecision(
                                                                            2) +
                                                                    ' % ' +
                                                                    AppStrings
                                                                        .off
                                                                        .tr()),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                        SizedBox(height: 10.h),
                                        Visibility(
                                          visible: product
                                              .descriptionStripTags.isNotEmpty,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Divider(),
                                              SizedBox(height: 10.h),
                                              CustomText(
                                                AppStrings.description.tr(),
                                              ),
                                              CustomCopyableWidget(
                                                copyText: product.name +
                                                    " \n \n " +
                                                    product
                                                        .descriptionStripTags,
                                                widget: HtmlWidget(
                                                  product.description,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          isGuest
                              ? const Padding(padding: EdgeInsets.zero)
                              : StatefulBuilder(
                                  builder: (context, buttonState) => product
                                              .quantityInCart !=
                                          '0'
                                      ? Card(
                                          elevation: 10,
                                          margin: EdgeInsets.zero,
                                          color: ColorManager.kWhite,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                15.w, 10.h, 15.w, 20.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  'Total'.tr() +
                                                      ' : ' +
                                                      '${int.parse(product.quantityInCart) * double.parse(product.price)}' +
                                                      ' ' +
                                                      'EGP'.tr(),
                                                  fontSize: 20.sp,
                                                ),
                                                CustomQuantityChanger(
                                                  fromDetails: true,
                                                  productId: product.id,
                                                  quantity:
                                                      product.quantityInCart,
                                                  minQuantity:
                                                      product.minQuantity,
                                                  maxQuantity:
                                                      product.maxQuantity,
                                                  storeAmounts:
                                                      product.storeAmounts,
                                                  changerBorderColor:
                                                      ColorManager.kGrey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            15.w,
                                            10.h,
                                            15.w,
                                            20.h,
                                          ),
                                          child: product.storeAmounts == 0 ||
                                                  product.price == '0'
                                              ? CustomElevatedButton(
                                                  onPressed: product
                                                              .addedListinerAvailable ||
                                                          (product.price ==
                                                                  '0' &&
                                                              product.storeAmounts >
                                                                  0)
                                                      ? null
                                                      : () => HelperFunctions
                                                              .showCustomModalBottomSheet(
                                                            isDismissible:
                                                                false,
                                                            context: context,
                                                            child:
                                                                CustomProductListenWidget(
                                                              onClick: (val) {
                                                                NavigationHelper
                                                                    .pop(
                                                                        context);
                                                                buttonState(
                                                                  () => product =
                                                                      product
                                                                          .copyWith(
                                                                    addedListinerAvailable:
                                                                        true,
                                                                  ),
                                                                );
                                                                context
                                                                    .read<
                                                                        ProductsBloc>()
                                                                    .add(
                                                                      AddListenToProductEvent(
                                                                        listenProductParameters:
                                                                            ListenProductParameters(
                                                                          productId:
                                                                              product.id,
                                                                          note:
                                                                              val,
                                                                        ),
                                                                      ),
                                                                    );
                                                              },
                                                            ),
                                                          ),
                                                  priColor:
                                                      ColorManager.notifyMe,
                                                  titleColor:
                                                      ColorManager.primaryLight,
                                                  title: product.storeAmounts !=
                                                          0
                                                      ? AppStrings.soon
                                                      : product
                                                              .addedListinerAvailable
                                                          ? AppStrings.notiYou
                                                          : AppStrings.notiMe,
                                                )
                                              : CustomElevatedButton(
                                                  onPressed: () {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(
                                                          AddItemEvent(
                                                            addItemParameters:
                                                                AddItemParameters(
                                                              productId:
                                                                  product.id,
                                                              quantity: 1,
                                                              productTypeName:
                                                                  product.stores
                                                                          .isNotEmpty
                                                                      ? product
                                                                          .stores
                                                                          .first
                                                                          .name
                                                                      : '',
                                                              offerId: product
                                                                      .offerId ??
                                                                  '',
                                                            ),
                                                          ),
                                                        );
                                                    context
                                                        .read<ProductsBloc>()
                                                        .add(
                                                          UpdateProductDetailsEvent(
                                                            productId:
                                                                product.id,
                                                            quantity: '1',
                                                          ),
                                                        );
                                                    context
                                                        .read<ProductsBloc>()
                                                        .add(
                                                          UpdateCustomProductEvent(
                                                            productId:
                                                                product.id,
                                                            quantity: '1',
                                                          ),
                                                        );
                                                    context
                                                        .read<HomeBloc>()
                                                        .add(
                                                          UpdateHomeProducts(
                                                            productId:
                                                                product.id,
                                                            quantity: '1',
                                                          ),
                                                        );
                                                  },
                                                  priColor:
                                                      ColorManager.primaryLight,
                                                  titleColor:
                                                      ColorManager.kWhite,
                                                  title: AppStrings.addToCart,
                                                ),
                                        ),
                                )
                        ],
                      ),
              );
      },
    );
  }
}
