import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo/app/utils/strings_manager.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../domain/entities/product_auto_complete.dart';

class SearchedProductWidget extends StatelessWidget {
  final ProductAutoComplete product;
  final void Function(String val) toProductDetails;
  const SearchedProductWidget(
      {Key? key, required this.product, required this.toProductDetails})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Card(
        color: ColorManager.swatch,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          onTap: () => toProductDetails(product.id),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 11.w,
            vertical: 12.h,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          leading: ImageBuilder(
            height: 73.h,
            width: 60.w,
            radius: 10.r,
            image:
                '${AppConstants.imgUrl.toString()}/products/${product.image}',
          ),
          title: CustomText(
            product.name,
            color: ColorManager.primary,
            maxLines: 2,
          ),
          subtitle: CustomText(
            product.price == '0' || product.storeAmounts == 0
                ? product.storeAmounts == 0
                    ? AppStrings.outOfStock.tr()
                    : AppStrings.soon.tr()
                : product.price + ' ' + AppStrings.egp.tr(),
            color: ColorManager.kBlack,
          ),
        ),
      );
}
