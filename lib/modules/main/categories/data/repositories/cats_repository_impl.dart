import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/services/network_services.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/mix_sub_trade.dart';
import '../../domain/repositories/base_cats_repository.dart';
import '../datasources/remote_data_source.dart';

class CatsRepositoryImpl implements BaseCatsRepository {
  final BaseCatsRemoteDataSource baseCatsRemoteDataSource;
  final NetworkServices networkServices;

  CatsRepositoryImpl(this.baseCatsRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, List<Category>>> getCategories(
      DataLimitation parameter) async {
    if (await networkServices.isConnected()) {
      try {
        final categoryResponse =
            await baseCatsRemoteDataSource.getCategories(parameter);
        if (categoryResponse.success) {
          return Right(categoryResponse.data);
        } else {
          return Left(ServerFailure(msg: categoryResponse.error!));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, MixSubTrade>> getMixSubTrade(int categoryId) async {
    if (await networkServices.isConnected()) {
      try {
        final subCategoryResponse =
            await baseCatsRemoteDataSource.getMixSubTrade(categoryId);
        if (subCategoryResponse.success) {
          return Right(
            MixSubTrade(
              subCategories: subCategoryResponse.data,
              trademarks: subCategoryResponse.famousTrademarks,
            ),
          );
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }
}
