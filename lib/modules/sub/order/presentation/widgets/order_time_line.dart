import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';

class OrderTimeLine extends StatelessWidget {
  final String currentStatus;
  final List<String> statusList;
  const OrderTimeLine(
      {Key? key, required this.statusList, required this.currentStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool cancel = currentStatus == 'canceled';
    int tempIndex = cancel
        ? -1
        : statusList.indexWhere((element) => element == currentStatus);
    List<String> tempList = cancel
        ? statusList
        : statusList.sublist(0, statusList.length - 1).toList();
    return Column(
      children: List.generate(
        tempList.length,
        (index) {
          bool markCancel = cancel && index == tempList.length - 1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Opacity(
                    opacity: index <= tempIndex || markCancel ? 1 : 0.5,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: markCancel
                          ? ColorManager.kRed
                          : ColorManager.primaryLight,
                      child: CustomText(
                        '${index + 1}',
                        color: ColorManager.kWhite,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    (tempList[index]).tr(),
                  )
                ],
              ),
              Visibility(
                visible: index != tempList.length - 1,
                child: Container(
                  height: 15.h,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: VerticalDivider(
                    color: ColorManager.primaryLight,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
