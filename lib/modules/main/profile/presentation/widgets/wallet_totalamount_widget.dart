// ignore_for_file: public_member_api_docs, sort_constructors_first, dead_code
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:turbo/modules/main/auth/domain/entities/user.dart';

import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../auth/data/models/user_model.dart';

class WalletTotalAmount extends StatelessWidget {
  const WalletTotalAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppShared appShared = sl<AppShared>();
    User user = UserModel.fromJson(appShared.getVal('user'));
    return Container(
        margin: EdgeInsets.only(right: 5.w, left: 5.w),
        height: 150.h,
        width: 400.w,
        decoration: BoxDecoration(
            color: ColorManager.primary2,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.wallet,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            Text(
              AppStrings.totalAmount.tr(),
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ));
  }
}
