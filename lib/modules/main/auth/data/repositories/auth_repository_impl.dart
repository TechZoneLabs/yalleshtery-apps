import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import '../datasources/local_data_source.dart';
import '../models/user_model.dart';

import '/app/services/network_services.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/base_auth_repository.dart';
import '../../domain/usecases/change_password_use_case.dart';
import '../../domain/usecases/log_in_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../domain/usecases/update_profile_use_case.dart';
import '../datasources/remote_data_source.dart';

class AuthRepositoryImpl implements BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;
  final BaseAuthLocalDataSource baseAuthLocalDataSource;
  final NetworkServices networkServices;

  AuthRepositoryImpl(
    this.baseAuthRemoteDataSource,
    this.networkServices,
    this.baseAuthLocalDataSource,
  );

  @override
  Future<Either<Failure, User>> logIn(LoginInputs userInputs) async {
    if (await networkServices.isConnected()) {
      try {
        final userResponse = await baseAuthRemoteDataSource.logIn(userInputs);
        if (userResponse.success) {
          baseAuthLocalDataSource.setUserData(userResponse.data!);
          return Right(userResponse.data!);
        } else {
          return Left(ServerFailure(msg: userResponse.message));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpInputs userInputs) async {
    if (await networkServices.isConnected()) {
      try {
        final userResponse = await baseAuthRemoteDataSource.signUp(userInputs);
        if (userResponse.success) {
          baseAuthLocalDataSource.setUserData(userResponse.data!);
          return Right(userResponse.data!);
        } else {
          return Left(ServerFailure(msg: userResponse.message));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if (await networkServices.isConnected()) {
      try {
        final result = await baseAuthRemoteDataSource.forgetPassword(email);
        if (result.success) {
          return Right(result.msg);
        } else {
          return Left(ServerFailure(msg: result.msg));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, String>> addDeviceToken() async {
    try {
      final val = await baseAuthRemoteDataSource.addDeviceToken();
      return Right(val);
    } on ServerExecption catch (_) {
      return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserData() async {
    if (await networkServices.isConnected()) {
      try {
        final userResponse = await baseAuthRemoteDataSource.getUserData();
        if (userResponse.success) {
          baseAuthLocalDataSource.setUserData(userResponse.data!);
          return Right(userResponse.data!);
        } else {
          return Left(ServerFailure(msg: userResponse.message));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      UserModel user = await baseAuthLocalDataSource.getUserData();
      return Right(user);
    }
  }

  @override
  Future<Either<Failure, bool>> logout(String token) async {
    if (await networkServices.isConnected()) {
      try {
        final result = await baseAuthRemoteDataSource.logout(token);
        if (result.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: result.msg));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
      PasswordInputs passwordInputs) async {
    if (await networkServices.isConnected()) {
      try {
        final result =
            await baseAuthRemoteDataSource.changePassword(passwordInputs);
        if (result.success) {
          return Right(result.msg);
        } else {
          return Left(ServerFailure(msg: result.msg));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile(UpdateInputs updateInputs) async {
    if (await networkServices.isConnected()) {
      try {
        final userResponse =
            await baseAuthRemoteDataSource.updateProfile(updateInputs);
        if (userResponse.success) {
          return Right(userResponse.data!);
        } else {
          return Left(ServerFailure(msg: userResponse.message));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount(String token) async {
    if (await networkServices.isConnected()) {
      try {
        final result = await baseAuthRemoteDataSource.deleteAccount(token);
        if (result.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: result.msg));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }
}
