import 'package:dartz/dartz.dart';

import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/trademark.dart';

abstract class BaseBrandsRepository {
  Future<Either<Failure, List<Trademark>>> getTradeMarks(
      DataLimitation parameter);
}
