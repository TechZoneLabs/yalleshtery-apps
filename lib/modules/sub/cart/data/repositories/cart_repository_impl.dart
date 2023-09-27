import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '/app/services/network_services.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/base_cart_repository.dart';
import '../../domain/usecases/add_item_to_cart_use_case.dart';
import '../../domain/usecases/check_promo_use_case.dart';
import '../../domain/usecases/update_cart_item_use_case.dart';
import '../datasources/remote_data_source.dart';

class CartRepositoryImpl implements BaseCartRepository {
  final BaseCartRemoteDataSource baseCartRemoteDataSource;
  final NetworkServices networkServices;

  CartRepositoryImpl(
    this.baseCartRemoteDataSource,
    this.networkServices,
  );

  @override
  Future<Either<Failure, Cart>> getCartData() async {
    if (await networkServices.isConnected()) {
      try {
        final cartResponse = await baseCartRemoteDataSource.getCartData();
        if (cartResponse.success) {
          return Right(cartResponse.data!);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> addItemToCart(
      AddItemParameters addItemPrameters) async {
    if (await networkServices.isConnected()) {
      try {
        final response =
            await baseCartRemoteDataSource.addItemToCart(addItemPrameters);
        if (response.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCartItem(
      UpdateItemParameters updateItemPrameters) async {
    if (await networkServices.isConnected()) {
      try {
        final response =
            await baseCartRemoteDataSource.updateCartItem(updateItemPrameters);
        if (response.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCartItem(String id) async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseCartRemoteDataSource.deleteCartItem(id);
        if (response.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> emptyCart() async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseCartRemoteDataSource.emptyCart();
        if (response.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, CouponInfo>> checkPromoCode(
      PromoParameters promoParameters) async {
    if (await networkServices.isConnected()) {
      try {
        final response =
            await baseCartRemoteDataSource.checkPromoCode(promoParameters);
        if (response.success) {
          return Right(response.data!);
        } else {
          return Left(ServerFailure(msg: response.message));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePromoCode(String id) async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseCartRemoteDataSource.deletePromoCode(id);
        if (response.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }
}
