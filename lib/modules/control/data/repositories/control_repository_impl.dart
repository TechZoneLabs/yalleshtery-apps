import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../app/errors/exception.dart';
import '../../../../app/errors/failure.dart';
import '../../../../app/services/network_services.dart';
import '../../../../app/utils/strings_manager.dart';
import '../../domain/entities/contact_info.dart';
import '../../domain/repositories/base_control_repositories.dart';
import '../datasources/remote_data_source.dart';

class ControlRepositoryImpl implements BaseControlRepository {
  final BaseControlRemoteDataSource baseControlRemoteDataSource;
  final NetworkServices networkServices;

  ControlRepositoryImpl(this.baseControlRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, ContactInfo>> getContactInfo() async {
    if (await networkServices.isConnected()) {
      try {
        final contactResponse =
            await baseControlRemoteDataSource.getContactInfo();
        if (contactResponse.success) {
          return Right(contactResponse.data);
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
