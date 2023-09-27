import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../control/presentation/widgets/custom_app_bar.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../../../sub/products/presentation/pages/temp_products_page.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favBox = Hive.box(AppConstants.favouriteKey);
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: CustomAppBar(
        context: context,
        hasBackButton: true,
        hasNotIcon: false,
        tempTitle: AppStrings.favourites.tr(),
      ),
      body: ValueListenableBuilder(
        valueListenable: favBox.listenable(),
        builder: (context, _, __) {
          var favList = favBox.values.toList();
          return favList.isEmpty
              ? Center(child: Lottie.asset('assets/json/empty.json'))
              : TempProductsPage(
                  productsParmeters: ProductsParmeters(ids: favList),
                  title: '',
                  fromFavoutites: true,
                );
        },
      ),
    );
  }
}
