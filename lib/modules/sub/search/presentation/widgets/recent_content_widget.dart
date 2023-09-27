import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/strings_manager.dart';

class RecentContentWidget extends StatelessWidget {
  final List<String> data;
  final void Function() onClear;
  final void Function(String recentVal) onTapRecent;

  const RecentContentWidget(
      {Key? key,
      required this.data,
      required this.onClear,
      required this.onTapRecent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool arabic = context.locale == AppConstants.arabic;
    return data.isEmpty
        ? Center(
            child: CustomText(
              'There are no recent searches'.tr(),
            ),
          )
        : Column(
            crossAxisAlignment:
                arabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onClear,
                child: CustomText(
                  AppStrings.clear.tr(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: data
                        .map(
                          (e) => Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ListTile(
                              onTap: () => onTapRecent(e),
                              contentPadding: EdgeInsets.zero,
                              title: CustomText(e),
                              trailing: Transform(
                                  alignment: AlignmentDirectional.center,
                                  transform: Matrix4.rotationY(
                                    HelperFunctions.rotateVal(
                                      context,
                                      rotate: true,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                      'assets/icons/arrow-up.svg')),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          );
  }
}
