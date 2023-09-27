import 'package:dartz/dartz.dart';


import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/trademark.dart';
import '../repositories/base_home_repository.dart';

class GetTrademarksUseCase
    implements BaseUseCase<Either<Failure, List<Trademark>>, DataLimitation> {
  final BaseBrandsRepository baseBrandsRepository;

  GetTrademarksUseCase(this.baseBrandsRepository);
  @override
  Future<Either<Failure, List<Trademark>>> call(DataLimitation parameter) =>
      baseBrandsRepository.getTradeMarks(parameter);
}
