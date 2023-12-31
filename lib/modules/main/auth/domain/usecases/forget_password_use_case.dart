import 'package:dartz/dartz.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_auth_repository.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<Either<Failure, String>, String> {
  final BaseAuthRepository baseAuthRepository;

  ForgetPasswordUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, String>> call(String parameters) =>
      baseAuthRepository.forgetPassword(parameters);
}
