import 'package:dartz/dartz.dart';
import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/category.dart';
import '../repositories/base_cats_repository.dart';

class GetCategoriesUseCase
    implements BaseUseCase<Either<Failure, List<Category>>, DataLimitation> {
  final BaseCatsRepository baseCatsRepository;

  GetCategoriesUseCase(this.baseCatsRepository);
  @override
  Future<Either<Failure, List<Category>>> call(DataLimitation parameter) =>
      baseCatsRepository.getCategories(parameter);
}
