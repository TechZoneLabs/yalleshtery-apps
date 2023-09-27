import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';

class Cart extends Equatable {
  final String id;
  final List<CartProduct> items;
  final List<Discount> discountList;
  final num totalPrice;
  final String totalDiscount;
  final int totalProductCount;
  final CouponInfo? couponInfo;

  const Cart({
    required this.id,
    required this.items,
    required this.discountList,
    required this.totalPrice,
    required this.totalDiscount,
    required this.totalProductCount,
    this.couponInfo,
  });
  Cart copyWith({List<CartProduct>? items}) => Cart(
        id: id,
        items: items ?? this.items,
        discountList: discountList,
        totalPrice: totalPrice,
        totalDiscount: totalDiscount,
        totalProductCount: totalProductCount,
      );
  @override
  List<Object?> get props => [
        id,
        items,
        discountList,
        totalPrice,
        totalDiscount,
        totalProductCount,
        couponInfo,
      ];
}

class CartProduct extends Equatable {
  final String id,
      cartId,
      productId,
      quantity,
      productName,
      productBarcode,
      productCode,
      price,
      image,
      offerId,
      productTypeName,
      minQuantity,
      maxQuantity;
  final bool hasLoading;
  final String? typeName, lastPrice;
  final int storeAmountsProduct, productTypeStoreCount;
  final OfferData? offerData;
  final String isGift;

  const CartProduct({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productBarcode,
    required this.productCode,
    required this.price,
    required this.image,
    required this.typeName,
    required this.storeAmountsProduct,
    required this.productTypeStoreCount,
    required this.lastPrice,
    this.offerData,
    required this.offerId,
    required this.productTypeName,
    required this.minQuantity,
    required this.maxQuantity,
    required this.isGift,
    this.hasLoading = false,
  });
  CartProduct copyWith({
    String? quantity,
    bool? hasLoading,
  }) =>
      CartProduct(
        id: id,
        cartId: cartId,
        productId: productId,
        quantity: quantity ?? this.quantity,
        productName: productName,
        productBarcode: productBarcode,
        productCode: productCode,
        price: price,
        image: image,
        typeName: typeName,
        storeAmountsProduct: storeAmountsProduct,
        productTypeStoreCount: productTypeStoreCount,
        lastPrice: lastPrice,
        offerData: offerData,
        offerId: offerId,
        productTypeName: productTypeName,
        minQuantity: minQuantity,
        maxQuantity: maxQuantity,
        isGift: isGift,
        hasLoading: hasLoading ?? this.hasLoading,
      );
  @override
  List<Object?> get props => [
        id,
        cartId,
        productId,
        quantity,
        productName,
        productBarcode,
        productCode,
        price,
        image,
        typeName,
        storeAmountsProduct,
        productTypeStoreCount,
        lastPrice,
        offerData,
        offerId,
        maxQuantity,
        minQuantity,
        hasLoading,
      ];
}

class Discount extends Equatable {
  final String offerId;
  final String discount;

  const Discount({required this.offerId, required this.discount});
  @override
  List<Object?> get props => [
        offerId,
        discount,
      ];
}

class CouponInfo extends Equatable {
  final String id, code, discountValue, discountType;

  const CouponInfo({
    required this.id,
    required this.code,
    required this.discountValue,
    required this.discountType,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        discountValue,
        discountType,
      ];
}
