import 'package:dartz/dartz.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/mix_sub_trade.dart';
import '../repositories/base_cats_repository.dart';

class GetMixSubTradeUseCase
    implements BaseUseCase<Either<Failure,MixSubTrade>, int> {
  final BaseCatsRepository baseCatsRepository;

  GetMixSubTradeUseCase(this.baseCatsRepository);
  @override
  Future<Either<Failure, MixSubTrade>> call(int categoryId) =>
      baseCatsRepository.getMixSubTrade(categoryId);
}
