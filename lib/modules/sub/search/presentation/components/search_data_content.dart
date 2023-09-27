import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../domain/entities/product_auto_complete.dart';
import '../widgets/searched_product_widget.dart';

class SearchDataContent extends StatelessWidget {
  final String searchVal;
  final List<ProductAutoComplete> data;
  final void Function(String val) toTempProducts,
      toProductDetails
      ;

  const SearchDataContent(
      {Key? key,
      required this.data,
      required this.searchVal,
      required this.toTempProducts,
      required this.toProductDetails,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          data.isNotEmpty
              ? Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: Card(
                    child: ListTile(
                      onTap: () => toTempProducts(searchVal),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      title: CustomText(searchVal),
                      trailing: Transform(
                        alignment: AlignmentDirectional.center,
                        transform: Matrix4.rotationY(
                          HelperFunctions.rotateVal(
                            context,
                            rotate: true,
                          ),
                        ),
                        child: SvgPicture.asset('assets/icons/arrow-up.svg'),
                      ),
                    ),
                  ),
                )
              : const Padding(padding: EdgeInsets.zero),
          SizedBox(height: 10.h),
          Column(
            children: data
                .map((e) => SearchedProductWidget(
                      product: e,
                      toProductDetails: toProductDetails,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
