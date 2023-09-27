import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_search_repository.dart';

class AddSearchProductReportsUseCase
    implements BaseUseCase<Either<Failure, bool>, SearchReportsParameters> {
  final BaseSearchRepository baseSearchRepository;

  AddSearchProductReportsUseCase(this.baseSearchRepository);
  @override
  Future<Either<Failure, bool>> call(SearchReportsParameters parameters) =>
      baseSearchRepository.addSearchProductReports(parameters);
}

class SearchReportsParameters extends Equatable {
  final String searchVal, totalCount;
  final String? searchTrademarkId, searchCategoryId;
  const SearchReportsParameters({
    required this.searchVal,
    required this.totalCount,
    this.searchTrademarkId,
    this.searchCategoryId,
  });
  Map<String, dynamic> toJson() => {
        "searchKey": searchVal,
        "total_count": totalCount,
        "brandID": searchTrademarkId ?? '',
        "searchCategoryId": searchCategoryId ?? '',
      };
  @override
  List<Object?> get props => [
        searchVal,
        totalCount,
        searchCategoryId,
        searchTrademarkId,
      ];
}
