import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/filter.dart';
import '../repositories/base_product_repository.dart';
import 'get_products_by_parameter_use_case.dart';

class GetFiltersUseCase
    implements BaseUseCase<Either<Failure, Filter>, ProductsParmeters> {
  final BaseProductRepository baseProductRepository;

  GetFiltersUseCase(this.baseProductRepository);
  @override
  Future<Either<Failure, Filter>> call(ProductsParmeters parmeters) =>
      baseProductRepository.getFilters(parmeters);
}
