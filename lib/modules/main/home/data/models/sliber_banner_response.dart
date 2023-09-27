import 'sliber_banner_model.dart';

class SliderBannerResponse {
  final bool success;
  final String? error;
  final List<SliderBannerModel> data;

  SliderBannerResponse({
    required this.success,
    this.error,
    required this.data,
  });

  factory SliderBannerResponse.fromJson(Map<String, dynamic> map) =>
      SliderBannerResponse(
        success: map['success'],
        error: map.containsKey('message') ? map['message'] : null,
        data: map.containsKey('data')
            ? (map['data'] as List)
                .map((e) => SliderBannerModel.fromJson(e))
                .toList()
            : [],
      );
}
