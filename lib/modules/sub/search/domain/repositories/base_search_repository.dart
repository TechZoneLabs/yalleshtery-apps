import 'package:dartz/dartz.dart';

import '../../../../../app/errors/failure.dart';
import '../entities/product_auto_complete.dart';
import '../usecases/add_search_product_report_use_case.dart';

abstract class BaseSearchRepository {
  Future<Either<Failure, ProductAutoCompleteData>> getSearchData(
    String searchVal,
  );
  Future<Either<Failure, bool>> addSearchProductReports(
      SearchReportsParameters searchReportsParameters);
}
