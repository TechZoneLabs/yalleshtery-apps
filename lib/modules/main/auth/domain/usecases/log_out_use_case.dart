import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_auth_repository.dart';

class LogoutUseCase implements BaseUseCase<Either<Failure, bool>, String> {
  final BaseAuthRepository baseAuthRepository;

  LogoutUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, bool>> call(String parameter) =>
      baseAuthRepository.logout(parameter);
}
