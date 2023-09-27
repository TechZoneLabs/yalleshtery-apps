import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxLines;
  final TextDecoration? decoration;
  final bool? softWrap;
  final double? height;
  final TextOverflow? overflow;
  const CustomText(
    this.title, {
    Key? key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.softWrap,
    this.height,
    this.overflow, this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      style: TextStyle(
        color: color,
        height: height,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: decoration,
      ),
    );
}
