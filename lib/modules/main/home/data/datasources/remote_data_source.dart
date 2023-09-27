import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../models/offer_response.dart';
import '../models/sliber_banner_response.dart';

abstract class BaseHomeRemoteDataSource {
  Future<SliderBannerResponse> getSliderBanners();
  Future<OfferResponse> getOffers();
}

class HomeRemoteDataSource implements BaseHomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSource(this.apiServices);
  @override
  Future<SliderBannerResponse> getSliderBanners() async {
    try {
      var map = await apiServices.get(
        file: 'banners.php',
        action: 'getBanners',
      );
      return SliderBannerResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<OfferResponse> getOffers() async {
    try {
      var map = await apiServices.get(
        file: 'offers.php',
        action: 'getOffersList',
      );
      return OfferResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
