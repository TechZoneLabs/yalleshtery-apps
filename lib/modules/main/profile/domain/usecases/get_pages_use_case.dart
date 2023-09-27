import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/page.dart';
import '../repositories/base_profile_repository.dart';

class GetPagesUseCase
    implements BaseUseCase<Either<Failure, List<PageEntity>>, NoParameters> {
  final BaseProfileRepository baseProfileRepository;

  GetPagesUseCase(this.baseProfileRepository);
  @override
  Future<Either<Failure, List<PageEntity>>> call(_) => baseProfileRepository.getPages();
}
