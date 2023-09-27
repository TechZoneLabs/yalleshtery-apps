import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/offer.dart';
import '../repositories/base_home_repository.dart';

class GetOffersUseCase
    implements BaseUseCase<Either<Failure, OfferType>, NoParameters> {
  final BaseHomeRepository baseHomeRepository;

  GetOffersUseCase(this.baseHomeRepository);
  @override
  Future<Either<Failure, OfferType>> call(_) => baseHomeRepository.getOffers();
}
