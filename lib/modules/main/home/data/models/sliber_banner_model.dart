import '../../domain/entities/slider_banner.dart';

class SliderBannerModel extends SliderBanner {
  const SliderBannerModel(
      {required String id,
      required String title,
      required String dateAdded,
      required String image,
      required String serName,
      required String bannerHeight,
      required String bannerWidth,
      required String type,
      required String urlType,
      required String url})
      : super(
          id: id,
          title: title,
          dateAdded: dateAdded,
          image: image,
          serName: serName,
          bannerHeight: bannerHeight,
          bannerWidth: bannerWidth,
          type: type,
          urlType: urlType,
          url: url,
        );
  factory SliderBannerModel.fromJson(Map<String, dynamic> map) =>
      SliderBannerModel(
        id: map['id'],
        title: map['title'] ?? '',
        dateAdded: map['date_added'] ?? '',
        image: map['image'] ?? '',
        serName: map['ser_name'] ?? '',
        bannerHeight: map['banner_height'] ?? '',
        bannerWidth: map['banner_width'] ?? '',
        type: map['type'] ?? '',
        urlType: map['url_type'] ?? '',
        url: map['url'] ?? '',
      );
}
