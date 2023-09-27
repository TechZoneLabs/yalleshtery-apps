import 'package:dartz/dartz.dart';

import '../../../../../app/errors/failure.dart';
import '../entities/user.dart';
import '../usecases/change_password_use_case.dart';
import '../usecases/log_in_use_case.dart';
import '../usecases/sign_up_use_case.dart';
import '../usecases/update_profile_use_case.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, User>> logIn(LoginInputs userInputs);
  Future<Either<Failure, User>> signUp(SignUpInputs userInputs);
  Future<Either<Failure, String>> forgetPassword(String email);
  Future<Either<Failure, String>> addDeviceToken();
  Future<Either<Failure, User>> getUserData();
  Future<Either<Failure, bool>> logout(String token);
  Future<Either<Failure, User>> updateProfile(UpdateInputs updateInputs);
  Future<Either<Failure, String>> changePassword(PasswordInputs passwordInputs);
  Future<Either<Failure, bool>> deleteAccount(String token);
}
