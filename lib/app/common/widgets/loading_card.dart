import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../utils/color_manager.dart';

class LoadingCard extends StatelessWidget {
  final double height;
  final double?  width, radius;
  final Color? color;
  const LoadingCard(
      {Key? key,required this.height, this.color, this.width, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
              color: color ?? ColorManager.swatch,
              borderRadius: BorderRadius.circular(radius ?? 5.r)),
          height: height,
          width: width ?? MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
