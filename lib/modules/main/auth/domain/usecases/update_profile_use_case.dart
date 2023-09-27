import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/base_auth_repository.dart';

class UpdateProfileUseCase
    implements BaseUseCase<Either<Failure, User>, UpdateInputs> {
  final BaseAuthRepository baseAuthRepository;

  UpdateProfileUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, User>> call(UpdateInputs parameters) =>
      baseAuthRepository.updateProfile(parameters);
}

class UpdateInputs extends Equatable {
  final String userName, email, mobile;
  const UpdateInputs({
    required this.userName,
    required this.email,
    required this.mobile,
  });
  toJson() => {
        'user_name': userName,
        'email': email,
        'mobile': mobile,
      };
  @override
  List<Object?> get props => [
        userName,
        email,
        mobile,
      ];
}
