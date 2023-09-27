import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/product_auto_complete.dart';
import '../repositories/base_search_repository.dart';

class GetSearchDataUseCase
    implements BaseUseCase<Either<Failure, ProductAutoCompleteData>, String> {
  final BaseSearchRepository baseSearchRepository;

  GetSearchDataUseCase(this.baseSearchRepository);
  @override
  Future<Either<Failure, ProductAutoCompleteData>> call(String searchVal) =>
      baseSearchRepository.getSearchData(searchVal);
}
