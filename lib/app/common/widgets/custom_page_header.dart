import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper/helper_functions.dart';
import '../../utils/color_manager.dart';
import '../../utils/constants_manager.dart';

class CustomPageHeader extends StatelessWidget {
  final double? height;
  final Widget child;
  final bool show;
  final Color? color;
  const CustomPageHeader(
      {Key? key,
      required this.child,
      this.height,
      this.show = true,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool arabic = context.locale == AppConstants.arabic;
    return Stack(
      alignment:
          arabic ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd,
      children: [
        Visibility(
          visible: show,
          child: Transform(
            alignment: AlignmentDirectional.topEnd,
            transform: Matrix4.rotationY(
              HelperFunctions.rotateVal(
                context,
                rotate: true,
              ),
            ),
            child: ClipPath(
              clipper: PageCliper(),
              child: Container(
                width: ScreenUtil().screenWidth / 2,
                height: height ?? 280.h,
                color: color ?? ColorManager.swatch,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: child,
        )
      ],
    );
  }
}

class PageCliper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.6);
    var controllPoint = Offset(40, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
