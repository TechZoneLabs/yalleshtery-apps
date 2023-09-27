import 'package:dartz/dartz.dart';
import '../../../../../app/common/usecase/base_use_case.dart';

import '../../../../../app/errors/failure.dart';
import '../repositories/base_cart_repository.dart';

class EmptyCartUseCase
    implements BaseUseCase<Either<Failure, bool>, NoParameters> {
  final BaseCartRepository baseCartRepository;

  EmptyCartUseCase(this.baseCartRepository);
  @override
  Future<Either<Failure, bool>> call(_) => baseCartRepository.emptyCart();
}
