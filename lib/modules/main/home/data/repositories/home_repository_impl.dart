import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/services/network_services.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/offer.dart';
import '../../domain/entities/slider_banner.dart';
import '../../domain/repositories/base_home_repository.dart';
import '../datasources/remote_data_source.dart';

class HomeRepositoryImpl implements BaseHomeRepository {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;
  final NetworkServices networkServices;

  HomeRepositoryImpl(this.baseHomeRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, List<SliderBanner>>> getSliderBanners() async {
    if (await networkServices.isConnected()) {
      try {
        final sliderResponse =
            await baseHomeRemoteDataSource.getSliderBanners();
        if (sliderResponse.success) {
          return Right(sliderResponse.data);
        } else {
          return Left(ServerFailure(msg: sliderResponse.error!));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, OfferType>> getOffers() async {
    if (await networkServices.isConnected()) {
      try {
        final offerResponse = await baseHomeRemoteDataSource.getOffers();
        if (offerResponse.success) {
          return Right(offerResponse.data!);
        } else {
          return Left(ServerFailure(msg: offerResponse.error!));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }
}
