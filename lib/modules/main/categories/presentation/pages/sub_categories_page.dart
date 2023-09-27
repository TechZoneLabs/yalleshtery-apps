import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../control/presentation/widgets/custom_app_bar.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../../../../app/common/widgets/custom_intrinsic_grid_view.dart';
import '../../../brands/presentation/widgets/custom_trademark_item.dart';
import '../controller/categories_bloc.dart';
import '../widgets/custom_category_item.dart';

class SubCategoriesPage extends StatelessWidget {
  const SubCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGuest = sl<AppShared>().getVal(AppConstants.userTokenKey) == '0';
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: CustomAppBar(
        context: context,
        hasBackButton: true,
        hasCartIcon: !isGuest,
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return state.mixSubTradeStatus == Status.loading
              ? const Center(
                  child: LoadingIndicatorWidget(),
                )
              : state.mixSubTradeStatus == Status.error
                  ? Center(child: Lottie.asset('assets/json/empty.json'))
                  : CustomPageHeader(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          width: ScreenUtil().screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible:
                                    state.mixSubTrade.subCategories.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      AppStrings.subCats.tr(),
                                      color: ColorManager.primary,
                                    ),
                                    SizedBox(height: 14.h),
                                    Center(
                                      child: CustomIntrinsicGridView(
                                        direction: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        horizontalSpace: 10.w,
                                        verticalSpace: 5.h,
                                        count: 3,
                                        children: state
                                            .mixSubTrade.subCategories
                                            .map(
                                              (e) => GestureDetector(
                                                onTap: () {
                                                  NavigationHelper.pushNamed(
                                                    context,
                                                    Routes.tempProductsRoute,
                                                    arguments: {
                                                      'title': e.serName,
                                                      'productsParmeters':
                                                          ProductsParmeters(
                                                        searchCategoryId: e.id,
                                                      ),
                                                    },
                                                  );
                                                },
                                                child: CustomCategryItem(
                                                  width: 1.sw / 3.5,
                                                  category: e,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Visibility(
                                visible:
                                    state.mixSubTrade.trademarks.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      AppStrings.trademarks.tr(),
                                      color: ColorManager.primary,
                                    ),
                                    SizedBox(height: 14.h),
                                    Center(
                                      child: CustomIntrinsicGridView(
                                        direction: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        horizontalSpace: 10.w,
                                        verticalSpace: 5.h,
                                        count: 3,
                                        children: state.mixSubTrade.trademarks
                                            .map((e) => CustomTradeMarkItem(
                                                  width: 1.sw / 3.5,
                                                  trademark: e,
                                                ))
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
