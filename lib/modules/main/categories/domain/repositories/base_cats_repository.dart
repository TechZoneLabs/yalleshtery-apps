import 'package:dartz/dartz.dart';
import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/category.dart';
import '../entities/mix_sub_trade.dart';

abstract class BaseCatsRepository {
  Future<Either<Failure, List<Category>>> getCategories(
    DataLimitation parameter,
  );
  Future<Either<Failure, MixSubTrade>> getMixSubTrade(int categoryId);
}
