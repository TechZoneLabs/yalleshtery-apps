import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/cart.dart';
import '../repositories/base_cart_repository.dart';

class GetCartDataUseCase
    implements BaseUseCase<Either<Failure, Cart>, NoParameters> {
  final BaseCartRepository baseCartRepository;

  GetCartDataUseCase(this.baseCartRepository);
  @override
  Future<Either<Failure, Cart>> call(_) => baseCartRepository.getCartData();
}
