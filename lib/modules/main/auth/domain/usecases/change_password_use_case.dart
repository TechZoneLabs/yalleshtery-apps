import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_auth_repository.dart';

class ChangePasswordUseCase
    implements BaseUseCase<Either<Failure, String>, PasswordInputs> {
  final BaseAuthRepository baseAuthRepository;

  ChangePasswordUseCase(this.baseAuthRepository);
  @override
  Future<Either<Failure, String>> call(PasswordInputs parameters) =>
      baseAuthRepository.changePassword(parameters);
}

class PasswordInputs extends Equatable {
  final String oldPassword, newPassword, confirmPassword;
  const PasswordInputs({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
  toJson() => {
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      };
  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
        confirmPassword,
      ];
}
