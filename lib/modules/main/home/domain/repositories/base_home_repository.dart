import 'package:dartz/dartz.dart';

import '../../../../../app/errors/failure.dart';
import '../entities/offer.dart';
import '../entities/slider_banner.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, List<SliderBanner>>> getSliderBanners();
  Future<Either<Failure, OfferType>> getOffers();
}
