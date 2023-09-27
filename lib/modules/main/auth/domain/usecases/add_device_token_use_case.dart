import 'package:dartz/dartz.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_auth_repository.dart';

class AddDeviceTokenUseCase
    implements BaseUseCase<Either<Failure, String>, NoParameters> {
  final BaseAuthRepository baseAuthRepository;

  AddDeviceTokenUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, String>> call(_) => baseAuthRepository.addDeviceToken();
}
