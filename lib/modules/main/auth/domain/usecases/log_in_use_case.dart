import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class LoginUseCase implements BaseUseCase<Either<Failure, User>, LoginInputs> {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, User>> call(LoginInputs parameters) =>
      baseAuthRepository.logIn(parameters);
}

class LoginInputs extends Equatable {
  final String mobile, password;
  const LoginInputs({
    required this.mobile,
    required this.password,
  });
  toJson() => {
        'mobile': mobile,
        'password': password,
      };
  @override
  List<Object?> get props => [mobile, password];
}
