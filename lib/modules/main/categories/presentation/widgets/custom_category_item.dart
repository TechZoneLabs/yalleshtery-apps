import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/categories_bloc.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../domain/entities/category.dart';

class CustomCategryItem extends StatelessWidget {
  final Category category;
  final double? width;
  const CustomCategryItem({Key? key, required this.category, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {
          if (category.haveSubService) {
            context.read<CategoriesBloc>().add(
                  GetMixSubTradeEvent(
                    categoryId: int.parse(category.id),
                  ),
                );
            NavigationHelper.pushNamed(
              context,
              Routes.subCategriesRoute,
            );
          } else {
            NavigationHelper.pushNamed(
              context,
              Routes.tempProductsRoute,
              arguments: {
                'title': category.serName,
                'productsParmeters': ProductsParmeters(
                  searchCategoryId: category.id,
                ),
              },
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ImageBuilder(
                radius: 5.r,
                height: 70.h,
                image:
                    '${AppConstants.imgUrl.toString()}/services/${category.serImage}',
              ),
            ),
            SizedBox(height: 5.h),
            CustomText(
              category.serName,
              maxLines: 2,
              textAlign: TextAlign.start,
              softWrap: true,
              height: 1.5,
              overflow: TextOverflow.ellipsis,
              color: Colors.black54,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
