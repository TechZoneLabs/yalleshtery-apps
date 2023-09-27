import '../../../../../app/common/model/general_response.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../../domain/usecases/add_item_to_cart_use_case.dart';
import '../../domain/usecases/check_promo_use_case.dart';
import '../../domain/usecases/update_cart_item_use_case.dart';
import '../models/cart_response.dart';
import '../models/coupon_info_response.dart';

abstract class BaseCartRemoteDataSource {
  Future<CartResponse> getCartData();
  Future<GerenalResponse> addItemToCart(
    AddItemParameters addItemPrameters,
  );
  Future<GerenalResponse> updateCartItem(
    UpdateItemParameters updateItemPrameters,
  );
  Future<GerenalResponse> deleteCartItem(String id);
  Future<GerenalResponse> emptyCart();
  Future<CouponInfoResponse> checkPromoCode(PromoParameters promoParameters);
  Future<GerenalResponse> deletePromoCode(String id);
}

class CartRemoteDataSource implements BaseCartRemoteDataSource {
  final ApiServices apiServices;

  CartRemoteDataSource(this.apiServices);
  @override
  Future<CartResponse> getCartData() async {
    try {
      var map = await apiServices.get(
        file: 'carts.php',
        action: 'getCart',
      );
      return CartResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> addItemToCart(
      AddItemParameters addItemPrameters) async {
    try {
      var map = await apiServices.post(
        file: 'carts.php',
        action: 'addToCart',
        body: addItemPrameters.toJson(),
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> updateCartItem(
      UpdateItemParameters updateItemPrameters) async {
    try {
      var map = await apiServices.post(
        file: 'carts.php',
        action: 'updateCartItem',
        body: updateItemPrameters.toJson(),
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> deleteCartItem(String id) async {
    try {
      var map = await apiServices.post(
        file: 'carts.php',
        action: 'deleteCartItem',
        body: {"key": id},
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> emptyCart() async {
    try {
      var map = await apiServices.post(
        file: 'carts.php',
        action: 'emptyCart',
        body: {},
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<CouponInfoResponse> checkPromoCode(
      PromoParameters promoParameters) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'add_use_coupon',
        body: promoParameters.toJson(),
      );
      return CouponInfoResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> deletePromoCode(String id) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'delete_use_coupon',
        body: {
          'id': id,
        },
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
