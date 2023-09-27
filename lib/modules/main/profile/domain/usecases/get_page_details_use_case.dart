import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/page.dart';
import '../repositories/base_profile_repository.dart';

class GetPageDetailsUseCase
    implements BaseUseCase<Either<Failure, PageEntity>, String> {
  final BaseProfileRepository baseProfileRepository;

  GetPageDetailsUseCase(this.baseProfileRepository);
  @override
  Future<Either<Failure, PageEntity>> call(String parameters) =>
      baseProfileRepository.getPageById(parameters);
}
