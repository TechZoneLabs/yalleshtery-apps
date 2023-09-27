import 'package:dartz/dartz.dart';

import '../../../../app/common/usecase/base_use_case.dart';
import '../../../../app/errors/failure.dart';
import '../entities/contact_info.dart';
import '../repositories/base_control_repositories.dart';

class ContactInfoUseCase
    implements BaseUseCase<Either<Failure, ContactInfo>, NoParameters> {
  final BaseControlRepository baseControlRepository;

  ContactInfoUseCase(this.baseControlRepository);
  @override
  Future<Either<Failure, ContactInfo>> call(_) =>
      baseControlRepository.getContactInfo();
}
