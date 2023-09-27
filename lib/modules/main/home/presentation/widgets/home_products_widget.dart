import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../../../../app/common/widgets/loading_card.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../sub/products/domain/entities/product.dart';
import 'custom_tiltle_row.dart';
import '../../../../sub/products/presentation/widgets/product_widget.dart';

class HomeProductsWidget extends StatelessWidget {
  final Status status;
  final String title;
  final TempProductsType tempProductsType;
  final List<Product> data;
  final EdgeInsetsGeometry padding;
  const HomeProductsWidget({
    Key? key,
    required this.data,
    required this.status,
    required this.title,
    required this.tempProductsType,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool notLoading = status == Status.loaded || status == Status.error;
    return Padding(
      padding: notLoading && data.isEmpty ? EdgeInsets.zero : padding,
      child: Column(
        children: [
          Visibility(
            visible: status != Status.error && data.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: CustomTitleRow(
                title: title,
                onTap: () => NavigationHelper.pushNamed(
                  context,
                  Routes.tempProductsRoute,
                  arguments: {
                    'title': tempProductsType == TempProductsType.bestSeler
                        ? AppStrings.productsOnSale.tr()
                        : AppStrings.newArrivals.tr(),
                    'productsParmeters': ProductsParmeters(
                      mode: tempProductsType == TempProductsType.bestSeler
                          ? 'best_seller'
                          : null,
                    ),
                  },
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                children: status == Status.initial
                    ? List.generate(
                        4,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            left: index == 3 ? 0 : 10,
                          ),
                          child: LoadingCard(
                            width: 155.w,
                            height: 270.h,
                            radius: 10.r,
                          ),
                        ),
                      )
                    : List.generate(
                        data.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: ProductWidget(
                            product: data[index],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
