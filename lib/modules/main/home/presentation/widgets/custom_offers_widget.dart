import 'package:date_count_down/date_count_down.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../sub/products/domain/usecases/get_product_details_use_case.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../../../sub/products/presentation/controller/products_bloc.dart';
import '../../domain/entities/offer.dart';

class CustomOffersWidget extends StatelessWidget {
  final List<OfferData> data;
  final EdgeInsetsGeometry padding;

  const CustomOffersWidget({
    Key? key,
    required this.data,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _generateItem(OfferData e) {
      DateTime offerEndDate =
          DateTime.parse(e.offerEndDate ?? '2022-06-20').add(
        const Duration(days: 1),
      );
      bool arabic = context.locale == AppConstants.arabic;
      return SizedBox(
        width: MediaQuery.of(context).size.width /
                (100 / int.parse(e.offerWidth)) -
            10,
        child: InkWell(
          onTap: () {
            debugPrint('banner click offer_on = ${e.offerOn}');
            if (e.offerOn == 'offer') {
              NavigationHelper.pushNamed(
                context,
                Routes.offerProductsRoute,
                arguments: {
                  'offerData': e,
                  'productsParmeters': ProductsParmeters(
                    offerId: e.offerOnId,
                  ),
                },
              );
            } else if (e.offerOn == 'products') {
              context.read<ProductsBloc>().add(
                    GetProductDetailsEvent(
                      productDetailsParmeters: ProductDetailsParmeters(
                        productId: e.offerOnId,
                      ),
                    ),
                  );
              NavigationHelper.pushNamed(
                context,
                Routes.productDetailsRoute,
              );
            } else if (e.offerOn == 'trademarks') {
              NavigationHelper.pushNamed(
                context,
                Routes.tempProductsRoute,
                arguments: {
                  'title': e.title,
                  'productsParmeters': ProductsParmeters(
                    searchTrademarkId: e.offerOnId,
                  ),
                },
              );
            } else if (e.offerOn == 'services') {
              NavigationHelper.pushNamed(
                context,
                Routes.tempProductsRoute,
                arguments: {
                  'title': e.title,
                  'productsParmeters': ProductsParmeters(
                    searchCategoryId: e.offerOnId,
                  ),
                },
              );
            }
          },
          child: Stack(
            children: [
              ImageBuilder(
                image: '${AppConstants.imgUrl}/offers/${e.image}',
                width: 1.sw,
                radius: 5,
              ),
              Visibility(
                visible: e.countdownTime == '1' &&
                    e.offerEndDate != null &&
                    double.parse(e.offerWidth) > 50,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.only(
                      topRight: arabic ? Radius.circular(5.r) : Radius.zero,
                      topLeft: !arabic ? Radius.circular(5.r) : Radius.zero,
                      bottomLeft: arabic ? Radius.circular(5.r) : Radius.zero,
                      bottomRight: !arabic ? Radius.circular(5.r) : Radius.zero,
                    ),
                  ),
                  child: CountDownText(
                    due: offerEndDate,
                    finishedText: "offer end".tr(),
                    showLabel: true,
                    longDateName: arabic ? true : false,
                    daysTextLong: ' ي ',
                    hoursTextLong: ' س ',
                    minutesTextLong: ' د ',
                    secondsTextLong: ' ثانية',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    List<Widget> _generateChildren() {
      List<Widget> items = [];
      for (int i = 0; i < data.length; i++) {
        String width = data[i].offerWidth;
        width = width == '33.33' ? '34' : width;
        items.add(_generateItem(data[i].copyWith(offerWidth: width)));
      }
      return items;
    }

    return Padding(
      padding: data.isEmpty ? EdgeInsets.zero : padding,
      child: Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: _generateChildren(),
      ),
    );
  }
}
