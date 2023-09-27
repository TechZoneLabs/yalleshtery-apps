import 'dart:io';
import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../../modules/sub/notification/presentation/controller/notification_bloc.dart';
import '../../modules/sub/products/presentation/controller/products_bloc.dart';

import '../../modules/sub/products/domain/entities/filter.dart';
import '../../modules/sub/products/domain/usecases/get_product_details_use_case.dart';
import '../../modules/sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../modules/sub/products/presentation/widgets/custom_filter_widget.dart';
import '../../modules/sub/products/presentation/widgets/custom_sort_widget.dart';
import '../common/model/alert_action_model.dart';
import '../common/widgets/custom_text.dart';
import '../services/services_locator.dart';
import '../utils/color_manager.dart';
import '../utils/constants_manager.dart';
import '../utils/routes_manager.dart';
import 'enums.dart';
import 'navigation_helper.dart';
import 'shared_helper.dart';
import 'update_checker.dart';

class HelperFunctions {
  static final AppShared _appShared = sl<AppShared>();
//checkArabic
  static bool checkArabic(String val) {
    if (val.isNotEmpty) {
      if (!val.contains(RegExp(r'[a-zA-Z]{1,}'))) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //isEmailValid
  static bool isEmailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  //showSnackBar
  static showSnackBar(BuildContext context, String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: CustomText(
            msg,
            textAlign: TextAlign.center,
          ),
        ),
      );
  //show popUpLoading alert
  static showPopUpLoadingAlert(BuildContext context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            height: 80,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
              ),
            ),
          ),
        ),
      );

  //change language
  static toggleLanguage(BuildContext context) {
    if (context.locale == AppConstants.arabic) {
      context.setLocale(AppConstants.english);
    } else {
      context.setLocale(AppConstants.arabic);
    }
  }

  //discountWidget
  static Widget discountWidget(String discount) => Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: ColorManager.discount,
            borderRadius: BorderRadius.circular(4.r)),
        child: CustomText(
          discount,
          maxLines: 3,
          textAlign: TextAlign.center,
          color: ColorManager.kRed,
          fontSize: 15.sp,
        ),
      );
  //Rotate value
  static double rotateVal(BuildContext context, {bool rotate = true}) {
    if (rotate && context.locale == AppConstants.arabic) {
      return math.pi;
    } else {
      return math.pi * 2;
    }
  }

//showAlert
  static showAlert(
      {required BuildContext context,
      String? title,
      required Widget content,
      List<AlertActionModel>? actions,
      bool forceAndroidStyle = false}) {
    Platform.isAndroid || forceAndroidStyle
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              contentPadding: EdgeInsets.fromLTRB(
                24,
                title == null ? 20 : 10,
                24,
                5,
              ),
              title: title == null ? null : Text(title),
              content: content,
              actions: actions == null
                  ? []
                  : actions
                      .map((action) => TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  action.color ?? ColorManager.primary,
                            ),
                            onPressed: action.onPressed,
                            child: Text(action.title),
                          ))
                      .toList(),
            ),
          )
        : showCupertinoDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: title == null ? null : Text(title),
              content: content,
              actions: actions == null
                  ? []
                  : actions
                      .map((action) => CupertinoDialogAction(
                            textStyle: TextStyle(
                              color: action.color ?? ColorManager.primary,
                            ),
                            child: Text(action.title),
                            onPressed: action.onPressed,
                          ))
                      .toList(),
            ),
          );
  }

//show CustomDialog
  static Future<void> showCustomDialog({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: isDismissible,
        barrierColor: ColorManager.kBlack.withOpacity(0.85),
        builder: (ctx) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: child,
        ),
      );
//show CustomModalBottomSheet
  static Future<void> showCustomModalBottomSheet({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible = true,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        builder: (context) => child,
      );
  //sort products
  static Future<SortStatus?> sortProducts(
      {required BuildContext context, required SortStatus? sortStatus}) async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => CustomSortWidget(
        sortStatus: sortStatus,
        onSelect: (status) {
          sortStatus = status;
          NavigationHelper.pop(context);
        },
      ),
    );
    return sortStatus;
  }

//filter products
  static Future<void> filterProducts({
    required BuildContext context,
    required Filter filters,
    required ProductsParmeters parmeters,
    required void Function(ProductsParmeters parmeters,int lastChoiceNumber) onApply,
    required void Function() onRest,
   
    required bool comeFromTrademark,
    required  int choiceNumber,
  }) =>
      showCustomModalBottomSheet(
        context: context,
        isScrollControlled: true,
        child: CustomFilterWidget(
          filters: filters,
          parmeters: parmeters,
          onApply: onApply,
          onRest: onRest,
         
          comeFromTrademark: comeFromTrademark,
          choiceNumber: choiceNumber,
        ),
      );

  //get favourites
  static List<String> getFavourite() {
    List temp = _appShared.getVal('favourite-key') ?? [];
    return temp.map((e) => e.toString()).toList();
  }

  //Check product favourite
  static bool productIsFavourite({required String productId}) {
    final Box list = Hive.box(AppConstants.favouriteKey);
    return list.containsKey(productId);
  }

  //set favourite
  static setFavourite({required String productId}) {
    final Box list = Hive.box(AppConstants.favouriteKey);
    list.put(productId, productId);
  }

  //un favourite
  static unFavourite({required String productId}) {
    final Box list = Hive.box(AppConstants.favouriteKey);
    list.delete(productId);
  }

  //handle notification action
  static void handleNotificationAction({
    required BuildContext context,
    required RemoteMessage message,
  }) {
    NotificationBloc notificationBloc = context.read<NotificationBloc>();
    notificationBloc.add(ReadNotificationEvent(id: message.data['id']));
    if (message.data['type'] == 'admin_notification' &&
        message.data['url'] != 0) {
      notificationBloc.add(
        GetNotificationDetailsEvent(
          id: message.data['url'].toString(),
        ),
      );
      NavigationHelper.pushNamed(context, Routes.notificationDetailsRoute);
    } else if (message.data['type'] == 'productAvailable' &&
        message.data['url'] != 0) {
      context.read<ProductsBloc>().add(
            GetProductDetailsEvent(
              productDetailsParmeters: ProductDetailsParmeters(
                productId: message.data['url'].toString(),
              ),
            ),
          );
      NavigationHelper.pushNamed(context, Routes.productDetailsRoute);
    }
    notificationBloc.add(GetUnReadNotificationEvent());
  }

  //update app
  static Future<bool> checkUpdate(BuildContext context) async {
    if (sl<AppShared>().getVal(AppConstants.updateAlertkKey) == null) {
      return UpdateChecker.displayUpdateAlert(
        context,
        forceUpdate: false,
        title: 'update-title'.tr(),
        description: 'update-description'.tr(),
        updateButtonLabel: 'update-bn-label'.tr(),
        closeButtonLabel: 'close-bn-label'.tr(),
        ignoreButtonLabel: 'ignore-bn-label'.tr(),
        onOpenAlert: () => sl<AppShared>().setVal(
          AppConstants.updateAlertkKey,
          true,
        ),
        onExitAlert: () => sl<AppShared>().removeVal(
          AppConstants.updateAlertkKey,
        ),
      );
    } else {
      return false;
    }
  }
}
