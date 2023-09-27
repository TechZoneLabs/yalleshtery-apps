import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../domain/entities/trademark.dart';

class CustomTradeMarkItem extends StatelessWidget {
  final double? width;
  final Trademark trademark;
  const CustomTradeMarkItem({Key? key, this.width, required this.trademark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () => NavigationHelper.pushNamed(
          context,
          Routes.tempProductsRoute,
          arguments: {
            'title': trademark.title,
            'productsParmeters': ProductsParmeters(
              searchTrademarkId: trademark.id,
            )
          },
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, spreadRadius: 1),
                ],
              ),
              child: ImageBuilder(
                radius: 10.r,
                height: 80.h,
                image:
                    '${AppConstants.imgUrl.toString()}/trademarks/${trademark.image}',
              ),
            ),
            SizedBox(height: 5.h),
            CustomText(
              trademark.title,
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
