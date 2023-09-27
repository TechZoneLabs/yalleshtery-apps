import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';


import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/services/network_services.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/trademark.dart';
import '../../domain/repositories/base_home_repository.dart';
import '../datasources/remote_data_source.dart';

class BrandsRepositoryImpl implements BaseBrandsRepository {
  final BaseBrandsRemoteDataSource baseBrandsRemoteDataSource;
  final NetworkServices networkServices;

  BrandsRepositoryImpl(this.baseBrandsRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, List<Trademark>>> getTradeMarks(DataLimitation parameter) async {
    if (await networkServices.isConnected()) {
      try {
        final trademarkResponse =
            await baseBrandsRemoteDataSource.getTradeMarks(parameter);
        if (trademarkResponse.success) {
          return Right(trademarkResponse.data);
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
