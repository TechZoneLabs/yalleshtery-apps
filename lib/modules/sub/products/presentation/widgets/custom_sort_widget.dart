import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/model/sort_model.dart';
import '../../../../../app/common/widgets/custom_radio_list.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';

class CustomSortWidget extends StatelessWidget {
  final SortStatus? sortStatus;
  final void Function(SortStatus sortStatus) onSelect;
  const CustomSortWidget({Key? key, this.sortStatus, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SortModel> sortList = [
      SortModel(
        title: 'Price from low to high'.tr(),
        sortStatus: SortStatus.lh,
      ),
      SortModel(
        title: 'Price from high to low'.tr(),
        sortStatus: SortStatus.hl,
      ),
      SortModel(
        title: 'New added'.tr(),
        sortStatus: SortStatus.newAdded,
      )
    ];
    int selectedIndex = sortList.indexWhere(
      (element) => element.sortStatus == sortStatus,
    );
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: CustomText('Sort by'.tr()),
              ),
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: const CloseButton(),
              ),
            ],
          ),
          const Divider(),
          Column(
            children: List.generate(
              sortList.length,
              (index) {
                bool select = index == selectedIndex;
                return CustomRadioList(
                  title: sortList[index].title,
                  selected: select,
                  onTap: () => onSelect(
                    sortList[index].sortStatus,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
