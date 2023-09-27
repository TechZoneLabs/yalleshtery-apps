import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../main/categories/domain/entities/category.dart';
import '../../../../main/categories/presentation/controller/categories_bloc.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';

class SubCategoriesTabsWidget extends StatelessWidget {
  final String selectedsubCategoryId;

  const SubCategoriesTabsWidget({
    Key? key,
    required this.selectedsubCategoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> subCategories = [];
    bool arabic = context.locale == AppConstants.arabic;
    int selectedIndex = 0;
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state.mixSubTradeStatus == Status.loaded) {
          Category tempCat = Category(
            id: selectedsubCategoryId,
            parent: selectedsubCategoryId,
            serName: 'All',
          );
          subCategories.insert(0, tempCat);
          subCategories.addAll(state.mixSubTrade.subCategories);
          int tempIndex = subCategories.indexWhere(
            (element) =>
                element.id == selectedsubCategoryId && element.serName != 'All',
          );
          subCategories.removeAt(tempIndex);
        }
        return StatefulBuilder(
          builder: (context, innerState) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                subCategories.length,
                (index) => GestureDetector(
                  onTap: () {
                    if (selectedIndex != index) {
                      innerState(() => selectedIndex = index);
                      NavigationHelper.pop(context);
                      NavigationHelper.pushNamed(
                        context,
                        Routes.tempProductsRoute,
                        arguments: {
                          'title': subCategories[index].serName,
                          'productsParmeters': ProductsParmeters(
                            searchCategoryId: subCategories[index].id,
                          ),
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: arabic
                        ? EdgeInsets.only(left: 10.h)
                        : EdgeInsets.only(right: 10.h),
                    child: CustomText(
                      index == 0
                          ? subCategories[index].serName.tr()
                          : subCategories[index].serName,
                      fontSize: 18.sp,
                      maxLines: 1,
                      color: selectedIndex == index
                          ? ColorManager.primaryLight
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
