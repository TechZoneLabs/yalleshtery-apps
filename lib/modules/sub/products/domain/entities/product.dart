import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String trademarkId;
  final String countTrademarkProduct;
  final String productCode;
  final String productBarcode;
  final String productWeight;
  final String merchantId;
  final String unitId;
  final String quantityInCart;
  final String price;
  final String commission;
  final String systemCommission;
  final String cost;
  final String priceOne;
  final String? lastPrice;
  final String priceHalf;
  final String priceMulti;
  final String priceGomlaGomla;
  final bool loadingCount;
  final String merchantSupply;
  final String renewable;
  final String productUrl;
  final String productNote;
  final String active;
  final String adminId;
  final String dateAdded;
  final String unitTitle;
  final String name;
  final String description;
  final String descriptionStripTags;
  final String? trademarkTitle;
  final int storeAmounts;
  final String serName;
  final List<Stores> stores;
  final List<ProductServices> productServices;
  final List<ProductTypes> productTypes;
  final String trademarkImage;
  final List<Images> images;
  final OfferData? offeData;
  final String? offerId;
  final String image;
  final String attachmentName;

  final dynamic affiliatorCommission;
  final bool addedListinerAvailable;
  final String minQuantity;
  final String maxQuantity;

  const Product({
    required this.id,
    required this.trademarkId,
    required this.countTrademarkProduct,
    required this.productCode,
    required this.productBarcode,
    required this.productWeight,
    required this.merchantId,
    required this.unitId,
    required this.quantityInCart,
    required this.price,
    required this.commission,
    required this.systemCommission,
    required this.cost,
    required this.priceOne,
    this.lastPrice,
    required this.priceHalf,
    required this.priceMulti,
    required this.priceGomlaGomla,
    this.loadingCount = false,
    required this.merchantSupply,
    required this.renewable,
    required this.productUrl,
    required this.productNote,
    required this.active,
    required this.adminId,
    required this.dateAdded,
    required this.unitTitle,
    required this.name,
    required this.description,
    required this.descriptionStripTags,
    this.trademarkTitle,
    required this.storeAmounts,
    required this.serName,
    required this.stores,
    required this.productServices,
    required this.productTypes,
    required this.images,
    required this.trademarkImage,
    this.offeData,
    this.offerId,
    required this.image,
    required this.attachmentName,
    this.affiliatorCommission,
    required this.addedListinerAvailable,
    required this.minQuantity,
    required this.maxQuantity,
  });

  Product copyWith({
    bool? addedListinerAvailable,
    String? quantityInCart,
  }) => Product(
        id: id,
        trademarkId: trademarkId,
        countTrademarkProduct: countTrademarkProduct,
        productCode: productCode,
        productBarcode: productBarcode,
        productWeight: productWeight,
        merchantId: merchantId,
        unitId: unitId,
        quantityInCart: quantityInCart ?? this.quantityInCart,
        price: price,
        commission: commission,
        systemCommission: systemCommission,
        cost: cost,
        priceOne: priceOne,
        priceHalf: priceHalf,
        priceMulti: priceMulti,
        priceGomlaGomla: priceGomlaGomla,
        merchantSupply: merchantSupply,
        renewable: renewable,
        productUrl: productUrl,
        productNote: productNote,
        active: active,
        adminId: adminId,
        dateAdded: dateAdded,
        unitTitle: unitTitle,
        name: name,
        description: description,
        descriptionStripTags: descriptionStripTags,
        storeAmounts: storeAmounts,
        serName: serName,
        stores: stores,
        productServices: productServices,
        productTypes: productTypes,
        images: images,
        trademarkImage: trademarkImage,
        image: image,
        attachmentName: attachmentName,
        addedListinerAvailable:
            addedListinerAvailable ?? this.addedListinerAvailable,
        minQuantity: minQuantity,
        maxQuantity: maxQuantity,
        lastPrice: lastPrice,
        trademarkTitle: trademarkTitle,
        offerId: offerId,
      );

  @override
  List<Object?> get props => [
        id,
        trademarkId,
        countTrademarkProduct,
        productCode,
        productBarcode,
        productWeight,
        merchantId,
        unitId,
        quantityInCart,
        price,
        commission,
        systemCommission,
        cost,
        priceOne,
        lastPrice,
        priceHalf,
        priceMulti,
        priceGomlaGomla,
        loadingCount,
        merchantSupply,
        renewable,
        productUrl,
        productNote,
        active,
        adminId,
        dateAdded,
        unitTitle,
        name,
        description,
        trademarkTitle,
        storeAmounts,
        serName,
        stores,
        productServices,
        productTypes,
        images,
        offeData,
        offerId,
        image,
        attachmentName,
        affiliatorCommission,
        addedListinerAvailable,
        minQuantity,
        maxQuantity,
      ];
}

class Stores extends Equatable {
  final String id;
  final String name;
  final String value;
  final String productId;
  final String productTypeId;
  final String forType;
  final String forId;
  final String type;
  final String adminId;
  final String dateAdded;
  final String storeTitle;
  final int storeAmountsProduct;

  const Stores({
    required this.id,
    required this.name,
    required this.value,
    required this.productId,
    required this.productTypeId,
    required this.forType,
    required this.forId,
    required this.type,
    required this.adminId,
    required this.dateAdded,
    required this.storeTitle,
    required this.storeAmountsProduct,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        value,
        productId,
        productTypeId,
        forType,
        forId,
        type,
        adminId,
        dateAdded,
        storeTitle,
        storeAmountsProduct,
      ];
}

class ProductServices extends Equatable {
  final String serviceId;
  final String parent;
  final String serviceSystemCommission;

  const ProductServices({
    required this.serviceId,
    required this.parent,
    required this.serviceSystemCommission,
  });
  @override
  List<Object?> get props => [
        serviceId,
        parent,
        serviceSystemCommission,
      ];
}

class ProductTypes extends Equatable {
  final String name;
  final String id;

  const ProductTypes({
    required this.name,
    required this.id,
  });
  @override
  List<Object?> get props => [
        name,
        id,
      ];
}

class Images extends Equatable {
  final String name;
  final String type;

  const Images({required this.name, required this.type});
  @override
  List<Object?> get props => [name, type];
}

class OfferData extends Equatable {
  final String offerType;
  final String title;
  final String description;
  final String attachmentSingle;

  const OfferData({
    required this.offerType,
    required this.title,
    required this.description,
    required this.attachmentSingle,
  });
  @override
  List<Object?> get props => [
        offerType,
        title,
        description,
        attachmentSingle,
      ];
}
