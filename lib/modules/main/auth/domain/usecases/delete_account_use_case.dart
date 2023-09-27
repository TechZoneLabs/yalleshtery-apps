import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_auth_repository.dart';

class DeteteAccountUseCase
    implements BaseUseCase<Either<Failure, bool>, String> {
  final BaseAuthRepository baseAuthRepository;

  DeteteAccountUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, bool>> call(String parameter) =>
      baseAuthRepository.deleteAccount(parameter);
}
