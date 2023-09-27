import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:turbo/modules/sub/search/domain/usecases/add_search_product_report_use_case.dart';

import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/services/network_services.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/product_auto_complete.dart';
import '../../domain/repositories/base_search_repository.dart';
import '../datasources/remote_data_source.dart';

class SearchRepositoryImpl implements BaseSearchRepository {
  final BaseSearchRemoteDataSource baseSearchRemoteDataSource;
  final NetworkServices networkServices;

  SearchRepositoryImpl(this.baseSearchRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, ProductAutoCompleteData>> getSearchData(
      String searchVal) async {
    if (await networkServices.isConnected()) {
      try {
        final searchResponse =
            await baseSearchRemoteDataSource.getSearchData(searchVal);
        if (searchResponse.success) {
          return Right(searchResponse.productAutoCompleteDataModel!);
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

  @override
  Future<Either<Failure, bool>> addSearchProductReports(
      SearchReportsParameters searchReportsParameters) async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseSearchRemoteDataSource
            .addSearchProductReports(searchReportsParameters);
        if (response.success) {
          return const Right(true);
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
