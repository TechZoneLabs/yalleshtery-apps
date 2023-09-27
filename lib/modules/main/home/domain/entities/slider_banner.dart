import 'package:equatable/equatable.dart';

class SliderBanner extends Equatable {
  final String id;
  final String bannerHeight;
  final String bannerWidth;
  final String dateAdded;
  final String image;
  final String type;
  final String urlType;
  final String url;
  final String title;
  final String serName;

  const SliderBanner({
    required this.id,
    required this.title,
    required this.dateAdded,
    required this.image,
    required this.serName,
    required this.bannerHeight,
    required this.bannerWidth,
    required this.type,
    required this.urlType,
    required this.url,
  });
  @override
  List<Object?> get props => [
        id,
        bannerHeight,
        bannerWidth,
        dateAdded,
        image,
        type,
        urlType,
        url,
        title,
        serName,
      ];
}
