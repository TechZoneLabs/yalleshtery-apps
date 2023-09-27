import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/cart.dart';
import '../repositories/base_cart_repository.dart';

class CheckPromoUseCase
    implements BaseUseCase<Either<Failure, CouponInfo>, PromoParameters> {
  final BaseCartRepository baseCartRepository;

  CheckPromoUseCase(this.baseCartRepository);
  @override
  Future<Either<Failure, CouponInfo>> call(PromoParameters parameters) =>
      baseCartRepository.checkPromoCode(parameters);
}

class PromoParameters extends Equatable {
  final String cartId, promoVal;

  const PromoParameters({required this.cartId, required this.promoVal});
  Map<String, dynamic> toJson() => {
        'mode_id': cartId,
        'mode': 'cart',
        'code': promoVal,
      };
  @override
  List<Object?> get props => [
        cartId,
        promoVal,
      ];
}
