import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/common/widgets/custom_text.dart';
import '../../../../app/helper/helper_functions.dart';
import '../../../../app/helper/navigation_helper.dart';
import '../../../../app/utils/color_manager.dart';
import '../../../sub/search/presentation/pages/search_page.dart';

class TempAppbar extends AppBar {
  TempAppbar({
    required BuildContext context,
    String? title,
    bool pinned = false,
    bool floating = false,
    bool scrolling = false,
    bool forceShowTilte = false,
    required void Function() sort,
    required void Function() filter,
    Color? sortColor,
    Color? filterColor,
    String? searchCategoryId,
    String? searchTrademarkId,
    Key? key,
  }) : super(
          key: key,
          backgroundColor: ColorManager.background,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 25,
            icon: Icon(Icons.arrow_back, color: ColorManager.kBlack),
            onPressed: () => NavigationHelper.pop(context),
          ),
          title: ((title != null && scrolling) || forceShowTilte)
              ? CustomText(
                  title!,
                  color: ColorManager.kBlack,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                )
              : null,
          centerTitle: false,
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              splashRadius: 25,
              icon: Transform(
                  alignment: AlignmentDirectional.center,
                  transform: Matrix4.rotationY(
                    HelperFunctions.rotateVal(
                      context,
                      rotate: true,
                    ),
                  ),
                  child: SvgPicture.asset('assets/icons/search.svg')),
              onPressed: () => NavigationHelper.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(
                    searchCategoryId: searchCategoryId,
                    searchTrademarkId: searchTrademarkId,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: scrolling,
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 25,
                    icon: SvgPicture.asset(
                      'assets/icons/sort.svg',
                      color: sortColor,
                    ),
                    onPressed: sort,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 25,
                    icon: SvgPicture.asset(
                      'assets/icons/filter.svg',
                      color: filterColor,
                    ),
                    onPressed: filter,
                  ),
                ],
              ),
            ),
          ],
        );
}
