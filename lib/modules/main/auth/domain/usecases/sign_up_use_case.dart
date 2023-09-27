import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class SignUpUseCsae
    implements BaseUseCase<Either<Failure, User>, SignUpInputs> {
  final BaseAuthRepository baseAuthRepository;

  SignUpUseCsae(this.baseAuthRepository);
  @override
  Future<Either<Failure, User>> call(SignUpInputs parameters) =>
      baseAuthRepository.signUp(parameters);
}

class SignUpInputs extends Equatable {
  final String userName, email, mobile, password;
  const SignUpInputs({
    required this.userName,
    required this.email,
    required this.mobile,
    required this.password,
  });
  toJson() => {
        "user_name": userName,
        "email": email,
        "mobile": mobile,
        "password": password
      };
  @override
  List<Object?> get props => [userName, email, mobile, password];
}
