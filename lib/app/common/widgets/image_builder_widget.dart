import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../utils/color_manager.dart';

class ImageBuilder extends StatelessWidget {
  final String image;
  final double radius;
  final double? height, width;
  final BoxFit fit;
  final Widget? placeHolder, errorImage;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const ImageBuilder({
    Key? key,
    required this.image,
    this.radius=0,
    this.height,
    this.width,
    this.fit= BoxFit.fill,
    this.placeHolder,
    this.errorImage,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String x = image.substring(image.lastIndexOf('/') + 1);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: x.length > 4
          ? CachedNetworkImage(
              imageUrl: image,
              height: height,
              width: width,
              fit: fit,
              imageBuilder: imageBuilder,
              placeholder: (context, string) =>
                  placeHolder ??
                  SizedBox(
                    height: height ?? 150,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primaryLight,
                        strokeWidth: 1,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  errorImage ??
                  Image.asset(
                    'assets/images/noImage.jpeg',
                    height: height,
                  ),
            )
          : errorImage ??
              Image.asset(
                'assets/images/noImage.jpeg',
                height: height,
              ),
    );
  }
}
