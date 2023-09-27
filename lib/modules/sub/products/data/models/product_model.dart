import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required String id,
      required String trademarkId,
      required String countTrademarkProduct,
      required String productCode,
      required String productBarcode,
      required String productWeight,
      required String merchantId,
      required String unitId,
      required String quantityInCart,
      required String price,
      required String commission,
      required String systemCommission,
      required String cost,
      required String priceOne,
      String? lastPrice,
      required String priceHalf,
      required String priceMulti,
      required String priceGomlaGomla,
      required String merchantSupply,
      required String renewable,
      required String productUrl,
      required String productNote,
      required String active,
      required String adminId,
      required String dateAdded,
      required String unitTitle,
      required String name,
      required String description,
      required String descriptionStripTags,
      String? trademarkTitle,
      required int storeAmounts,
      required String serName,
      required List<Stores> stores,
      required List<ProductServices> productServices,
      required List<ProductTypes> productTypes,
      required List<Images> images,
      OfferData? offeData,
      String? offerId,
      required String trademarkImage,
      required String image,
      required String attachmentName,
      required bool addedListinerAvailable,
      required String minQuantity,
      required String maxQuantity})
      : super(
          id: id,
          trademarkId: trademarkId,
          countTrademarkProduct: countTrademarkProduct,
          productCode: productCode,
          productBarcode: productBarcode,
          productWeight: productWeight,
          merchantId: merchantId,
          unitId: unitId,
          quantityInCart: quantityInCart,
          price: price,
          commission: commission,
          systemCommission: systemCommission,
          cost: cost,
          priceOne: priceOne,
          lastPrice: lastPrice,
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
          trademarkTitle: trademarkTitle,
          storeAmounts: storeAmounts,
          serName: serName,
          stores: stores,
          productServices: productServices,
          productTypes: productTypes,
          images: images,
          offeData: offeData,
          offerId: offerId,
          trademarkImage: trademarkImage,
          image: image,
          attachmentName: attachmentName,
          addedListinerAvailable: addedListinerAvailable,
          minQuantity: minQuantity,
          maxQuantity: maxQuantity,
        );

  factory ProductModel.fromJson(Map<String, dynamic> map) => ProductModel(
        adminId: map['admin_id'] ?? '',
        name: map['name'],
        id: map['id'],
        dateAdded: map['date_added'],
        serName: map['ser_name'],
        image: map['image'] ?? '',
        active: map['active'],
        commission: map['commission'],
        cost: map['cost'],
        countTrademarkProduct: map['count_trademark_product'],
        description: map['description'],
        descriptionStripTags: map['description_strip_tags'] ?? '',
        merchantId: map['merchant_id'],
        merchantSupply: map['merchant_supply'],
        price: map['price'],
        lastPrice: map['last_price'],
        priceGomlaGomla: map['price_gomla_gomla'],
        priceHalf: map['price_half'],
        priceMulti: map['price_multi'],
        priceOne: map['price_one'],
        quantityInCart: map['quantity_in_cart'],
        productBarcode: map['product_barcode'],
        productCode: map['product_code'],
        productNote: map['product_note'],
        productUrl: map['product_url'],
        productWeight: map['product_weight'],
        renewable: map['renewable'],
        storeAmounts: map['store_amounts'],
        systemCommission: map['system_commission'],
        trademarkId: map['trademark_id'],
        trademarkTitle: map['trademark_title'],
        unitId: map['unit_id'],
        unitTitle: map['unit_title'] ?? '',
        addedListinerAvailable: map['added_listiner_available'],
        productServices: map.containsKey('product_services')
            ? (map['product_services'] as List)
                .map((e) =>
                    ProductServicesModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        productTypes: map.containsKey('product_types')
            ? (map['product_types'] as List)
                .map((e) =>
                    ProductTypesModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        stores: map.containsKey('stores')
            ? (map['stores'] as List)
                .map((e) => StoresModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        images: map.containsKey('images')
            ? (map['images'] as List)
                .map((e) => ImagesModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        offerId: map['offer_id'] ?? '',
        attachmentName: map['attachment_name'] ?? '',
        offeData: map['offer_data'] != null
            ? OfferDataModel.fromJson(map['offer_data'])
            : null,
        minQuantity: map['min_quantity'] ?? '',
        maxQuantity: map['max_quantity'] ?? '',
        trademarkImage: map['trademark_image'] ?? '',
      );
}

class StoresModel extends Stores {
  const StoresModel({
    required String id,
    required String name,
    required String value,
    required String productId,
    required String productTypeId,
    required String forType,
    required String forId,
    required String type,
    required String adminId,
    required String dateAdded,
    required String storeTitle,
    required int storeAmountsProduct,
  }) : super(
          id: id,
          name: name,
          value: value,
          productId: productId,
          productTypeId: productTypeId,
          forType: forType,
          forId: forId,
          type: type,
          adminId: adminId,
          dateAdded: dateAdded,
          storeTitle: storeTitle,
          storeAmountsProduct: storeAmountsProduct,
        );
  factory StoresModel.fromJson(Map<String, dynamic> map) => StoresModel(
        type: map['type'] ?? '',
        dateAdded: map['date_added'] ?? '',
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        value: map['value'] ?? '',
        adminId: map['admin_id'] ?? '',
        forId: map['for_id'] ?? '',
        forType: map['for_type'] ?? '',
        productId: map['product_id'] ?? '',
        storeAmountsProduct: map['store_amounts_product'] ?? 0,
        productTypeId: map['product_type_id'] ?? '',
        storeTitle: map['store_title'] ?? '',
      );
}

class ProductServicesModel extends ProductServices {
  const ProductServicesModel(
      {required String serviceId,
      required String parent,
      required String serviceSystemCommission})
      : super(
          serviceId: serviceId,
          parent: parent,
          serviceSystemCommission: serviceSystemCommission,
        );
  factory ProductServicesModel.fromJson(Map<String, dynamic> map) =>
      ProductServicesModel(
        serviceId: map['service_id'] ?? '',
        parent: map['parent'] ?? '',
        serviceSystemCommission: map['service_system_commission'] ?? '',
      );
}

class ProductTypesModel extends ProductTypes {
  const ProductTypesModel({required String name, required String id})
      : super(
          name: name,
          id: id,
        );
  factory ProductTypesModel.fromJson(Map<String, dynamic> map) =>
      ProductTypesModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
      );
}

class ImagesModel extends Images {
  const ImagesModel({required String name, required String type})
      : super(
          name: name,
          type: type,
        );
  factory ImagesModel.fromJson(Map<String, dynamic> map) => ImagesModel(
        name: map['name'] ?? '',
        type: map['type'] ?? '',
      );
}

class OfferDataModel extends OfferData {
  const OfferDataModel({
    required String offerType,
    required String title,
    required String description,
    required String attachmentSingle,
  }) : super(
          offerType: offerType,
          title: title,
          description: description,
          attachmentSingle: attachmentSingle,
        );

  factory OfferDataModel.fromJson(Map<String, dynamic> map) => OfferDataModel(
        offerType: map['offer_type'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        attachmentSingle: map['attachment_single'] ?? '',
      );
}
