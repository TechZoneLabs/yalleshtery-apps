import 'package:dartz/dartz.dart';

import '../../../../../app/errors/failure.dart';
import '../entities/cart.dart';
import '../usecases/add_item_to_cart_use_case.dart';
import '../usecases/check_promo_use_case.dart';
import '../usecases/update_cart_item_use_case.dart';

abstract class BaseCartRepository {
  Future<Either<Failure, Cart>> getCartData();
  Future<Either<Failure, bool>> addItemToCart(
    AddItemParameters addItemPrameters,
  );
  Future<Either<Failure, bool>> updateCartItem(
    UpdateItemParameters updateItemPrameters,
  );
  Future<Either<Failure, bool>> deleteCartItem(String id);
  Future<Either<Failure, bool>> emptyCart();
  Future<Either<Failure, CouponInfo>> checkPromoCode(
    PromoParameters promoParameters,
  );
  Future<Either<Failure, bool>> deletePromoCode(String id);
}
