import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class GetUserDataUseCase
    implements BaseUseCase<Either<Failure, User>, NoParameters> {
  final BaseAuthRepository baseAuthRepository;

  GetUserDataUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, User>> call(_) => baseAuthRepository.getUserData();
}
