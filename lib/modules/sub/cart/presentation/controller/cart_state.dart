part of 'cart_bloc.dart';

class CartState extends Equatable {
  final String msg;
  final Status cartStatus;
  final Cart? cart;
  final String cartNum;
  final Status addItemStatus;
  final Status updateItemStatus;
  final Status deleteItemStatus;
  final String deleteItemProdId;
  final Status emptyCartStatus;
  final Status promoStatus;
  final CouponInfo? couponInfo;
  final bool clearCoupon;

  const CartState({
    this.msg = '',
    this.cartStatus = Status.sleep,
    this.cart,
    this.cartNum = '0',
    this.addItemStatus = Status.sleep,
    this.updateItemStatus = Status.sleep,
    this.deleteItemStatus = Status.sleep,
    this.deleteItemProdId = '',
    this.emptyCartStatus = Status.sleep,
    this.promoStatus = Status.sleep,
    this.couponInfo,
    this.clearCoupon = false,
  });

  CartState copyWith({
    String? msg,
    Status? cartStatus,
    Cart? cart,
    String? cartNum,
    Status? addItemStatus,
    Status? updateItemStatus,
    Status? deleteItemStatus,
    String? deleteItemProdId,
    Status? emptyCartStatus,
    Status? promoStatus,
    CouponInfo? couponInfo,
  }) =>
      CartState(
        msg: msg ?? this.msg,
        cartStatus: cartStatus ?? this.cartStatus,
        cart: cart ?? this.cart,
        cartNum: cartNum ?? this.cartNum,
        addItemStatus: addItemStatus ?? this.addItemStatus,
        updateItemStatus: updateItemStatus ?? this.updateItemStatus,
        deleteItemStatus: deleteItemStatus ?? this.deleteItemStatus,
        deleteItemProdId: deleteItemProdId ?? this.deleteItemProdId,
        emptyCartStatus: emptyCartStatus ?? this.emptyCartStatus,
        promoStatus: promoStatus ?? this.promoStatus,
        couponInfo: promoStatus == Status.error && couponInfo == null ||
                promoStatus == Status.loaded && couponInfo == null ||
                emptyCartStatus == Status.loaded
            ? null
            : couponInfo ?? this.couponInfo,
      );

  @override
  List<Object?> get props => [
        msg,
        cartStatus,
        cart,
        cartNum,
        addItemStatus,
        updateItemStatus,
        deleteItemStatus,
        deleteItemProdId,
        emptyCartStatus,
        promoStatus,
        couponInfo,
      ];
}
