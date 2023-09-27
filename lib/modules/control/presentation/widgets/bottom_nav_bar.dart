import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/utils/color_manager.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomNavBar(
      {Key? key, required this.onTap, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.primaryLight,
        unselectedItemColor: ColorManager.kGrey,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            label: 'Home'.tr(),
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: currentIndex == 0 ? ColorManager.primaryLight : null,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Categories'.tr(),
            icon: SvgPicture.asset(
              'assets/icons/cats.svg',
              color: currentIndex == 1 ? ColorManager.primaryLight : null,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Brands'.tr(),
            icon: SvgPicture.asset(
              'assets/icons/brands.svg',
              color: currentIndex == 2 ? ColorManager.primaryLight : null,
            ),
          ),
          BottomNavigationBarItem(
            label: 'More'.tr(),
            icon: SvgPicture.asset(
              'assets/icons/more.svg',
              color: currentIndex == 3 ? ColorManager.primaryLight : null,
            ),
          ),
        ],
      );
}
