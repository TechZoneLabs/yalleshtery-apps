import '../../../products/data/models/product_model.dart';
import '../../domain/entities/cart.dart';

class CartModel extends Cart {
  const CartModel({
    required String id,
    required List<CartProduct> items,
    required List<Discount> discountList,
    required num totalPrice,
    required String totalDiscount,
    required int totalProductCount,
    CouponInfo? couponInfo,
  }) : super(
          id: id,
          items: items,
          discountList: discountList,
          totalPrice: totalPrice,
          totalDiscount: totalDiscount,
          totalProductCount: totalProductCount,
          couponInfo: couponInfo,
        );
  factory CartModel.fromJson(Map<String, dynamic> map) => CartModel(
        id: map['id'],
        items: map.containsKey('product_items')
            ? (map['product_items'] as List)
                .map((e) => CartProductModel.fromJson(e))
                .toList()
            : [],
        discountList: map.containsKey('discount_array')
            ? (map['discount_array'] as List)
                .map((e) => DiscountModel.fromJson(e))
                .toList()
            : [],
        totalPrice: map['total_price'] ?? 0.0,
        totalDiscount: map['total_discount'] ?? '0.0',
        totalProductCount: map['total_product_count'] ?? 0,
        couponInfo: map.containsKey('couponInfo')
            ? map['couponInfo'] is String
                ? null
                : CouponInfoModel.fromJson(map['couponInfo'])
            : null,
      );
}

class CartProductModel extends CartProduct {
  const CartProductModel(
      {required String id,
      required String cartId,
      required String productId,
      required String quantity,
      required String productName,
      required String productBarcode,
      required String productCode,
      required String price,
      required String image,
      String? typeName,
      required int storeAmountsProduct,
      required int productTypeStoreCount,
      String? lastPrice,
      OfferDataModel? offerData,
      required String offerId,
      required String productTypeName,
      required String minQuantity,
      required String maxQuantity,
      required String isGift})
      : super(
          id: id,
          cartId: cartId,
          productId: productId,
          quantity: quantity,
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
        );
  factory CartProductModel.fromJson(Map<String, dynamic> map) =>
      CartProductModel(
        id: map['id'],
        cartId: map['cart_id'] ?? '',
        productId: map['product_id'],
        quantity: map['quantity'],
        productName: map['product_name'],
        productBarcode: map['product_barcode'],
        productCode: map['product_code'],
        price: map['price'],
        image: map['image'],
        typeName: map['type_name'],
        storeAmountsProduct: map['store_amounts_product'] ?? 0,
        productTypeStoreCount: map['product_type_store_count'] ?? 0,
        lastPrice: map['last_price'],
        productTypeName: map['product_type_name'] ?? '',
        offerData: map['offer_data'] != null
            ? OfferDataModel.fromJson(map['offer_data'])
            : null,
        offerId: map['offer_id'] ?? '',
        minQuantity: map['min_quantity'] ?? '',
        maxQuantity: map['max_quantity'] ?? '',
        isGift: map['is_gift'] ?? '0',
      );
}

class DiscountModel extends Discount {
  const DiscountModel({required String offerId, required String discount})
      : super(
          offerId: offerId,
          discount: discount,
        );
  factory DiscountModel.fromJson(Map<String, dynamic> map) => DiscountModel(
        offerId: map['offer_id'],
        discount: map['discount'],
      );
}

class CouponInfoModel extends CouponInfo {
  const CouponInfoModel({
    required String id,
    required String code,
    required String discountValue,
    required String discountType,
  }) : super(
          id: id,
          code: code,
          discountValue: discountValue,
          discountType: discountType,
        );
  factory CouponInfoModel.fromJson(Map<String, dynamic> map) => CouponInfoModel(
        id: map['id'] ?? '',
        code: map['code'] ?? '',
        discountValue: map['discount_value'] ?? '',
        discountType: map['discount_type'] ?? '',
      );
}
