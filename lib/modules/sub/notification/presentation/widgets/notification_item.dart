import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/notification.dart' as not;

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../products/domain/usecases/get_product_details_use_case.dart';
import '../../../products/presentation/controller/products_bloc.dart';
import '../controller/notification_bloc.dart';

class NotificationItem extends StatelessWidget {
  final not.Notification notification;
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationBloc notificationBloc = context.read<NotificationBloc>();
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.r,
        ),
        side: BorderSide(
          color: ColorManager.kGrey.withOpacity(0.5),
        ),
      ),
      child: ListTile(
        onTap: () {
          if (notification.pageType == "admin_notification") {
            notificationBloc.add(
              GetNotificationDetailsEvent(
                id: notification.id,
              ),
            );
            NavigationHelper.pushNamed(
              context,
              Routes.notificationDetailsRoute,
            );
          } else if (notification.pageType == "productAvailable") {
            context.read<ProductsBloc>().add(
                  GetProductDetailsEvent(
                    productDetailsParmeters: ProductDetailsParmeters(
                      productId: notification.url,
                    ),
                  ),
                );
            NavigationHelper.pushNamed(
              context,
              Routes.productDetailsRoute,
            );
          }
          if (notification.status == '0') {
            notificationBloc.add(
              ReadNotificationEvent(
                id: notification.id,
              ),
            );
          }
        },
        leading: CircleAvatar(
          backgroundColor: ColorManager.kGrey.withOpacity(0.2),
          child: SvgPicture.asset(
            'assets/icons/not.svg',
          ),
        ),
        title: CustomText(
          notification.title,
        ),
        subtitle: CustomText(
          DateFormat(
            'yyyy:MM:dd | hh:mm a',
            'en',
          ).format(
            DateTime.parse(
              notification.dateAdded,
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: () => notificationBloc.add(
            DeleteNotificationEvent(id: notification.id),
          ),
          icon: SvgPicture.asset(
            'assets/icons/delete.svg',
            color: ColorManager.kBlack,
          ),
        ),
      ),
    );
  }
}
