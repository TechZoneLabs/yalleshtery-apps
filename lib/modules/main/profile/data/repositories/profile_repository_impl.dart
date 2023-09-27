import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/services/network_services.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/page.dart';
import '../../domain/repositories/base_profile_repository.dart';
import '../datasources/remote_data_source.dart';

class ProfileRepositoryImpl implements BaseProfileRepository {
  final BaseProfileRemoteDataSource baseProfileRemoteDataSource;
  final NetworkServices networkServices;

  ProfileRepositoryImpl(this.baseProfileRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, List<PageEntity>>> getPages() async {
    if (await networkServices.isConnected()) {
      try {
        final pageResponse = await baseProfileRemoteDataSource.getPages();
        if (pageResponse.success) {
          return Right(pageResponse.pageList);
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
  Future<Either<Failure, PageEntity>> getPageById(String id) async {
    if (await networkServices.isConnected()) {
      try {
        final pageResponse = await baseProfileRemoteDataSource.getPageById(id);
        if (pageResponse.success) {
          return Right(pageResponse.pageDetails!);
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
