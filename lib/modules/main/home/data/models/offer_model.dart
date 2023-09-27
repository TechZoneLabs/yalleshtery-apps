import '../../domain/entities/offer.dart';

class OfferTypeModel extends OfferType {
  const OfferTypeModel(
      {required List<OfferData> inSlider,
      required List<OfferData> inCategories,
      required List<OfferData> inLastProducts,
      required List<OfferData> inTrademarks})
      : super(
          inSlider: inSlider,
          inCategories: inCategories,
          inLastProducts: inLastProducts,
          inTrademarks: inTrademarks,
        );
  factory OfferTypeModel.fromJson(Map<String, dynamic> map) => OfferTypeModel(
        inSlider: map.containsKey('in_slider')
            ? (map['in_slider'] as List)
                .map((e) => OfferDataModel.fromJson(e))
                .toList()
            : [],
        inCategories: map.containsKey('in_categories')
            ? (map['in_categories'] as List)
                .map((e) => OfferDataModel.fromJson(e))
                .toList()
            : [],
        inLastProducts: map.containsKey('in_last_products')
            ? (map['in_last_products'] as List)
                .map((e) => OfferDataModel.fromJson(e))
                .toList()
            : [],
        inTrademarks: map.containsKey('in_trademarks')
            ? (map['in_trademarks'] as List)
                .map((e) => OfferDataModel.fromJson(e))
                .toList()
            : [],
      );
}

class OfferDataModel extends OfferData {
  const OfferDataModel({
    required String id,
    required String priority,
    required String offerStartDate,
    String? offerEndDate,
    required String offerType,
    required String priceType,
    required String offerWidth,
    required String showOn,
    required String showOnPlaces,
    required String active,
    required String image,
    required String adminId,
    required String affiliatorId,
    required String sort,
    required String dateAdded,
    required String title,
    required String offerOn,
    required String offerOnId,
    required description,
    required countdownTime,
  }) : super(
          id: id,
          priority: priority,
          offerStartDate: offerStartDate,
          offerEndDate: offerEndDate,
          offerType: offerType,
          priceType: priceType,
          offerWidth: offerWidth,
          showOn: showOn,
          showOnPlaces: showOnPlaces,
          active: active,
          image: image,
          adminId: adminId,
          affiliatorId: affiliatorId,
          sort: sort,
          dateAdded: dateAdded,
          title: title,
          offerOn: offerOn,
          offerOnId: offerOnId,
          description: description,
          countdownTime: countdownTime,
        );
  factory OfferDataModel.fromJson(Map<String, dynamic> map) => OfferDataModel(
      id: map['id'],
      priority: map['priority'],
      offerStartDate: map['offer_start_date'],
      offerEndDate: map['offer_end_date'],
      offerType: map['offer_type'],
      priceType: map['price_type'],
      offerWidth: map['offer_width'],
      showOn: map['show_on'],
      showOnPlaces: map['show_on_places'],
      active: map['active'],
      image: map['image'],
      adminId: map['admin_id'],
      affiliatorId: map['affiliator_id'],
      sort: map['sort'],
      dateAdded: map['date_added'],
      title: map['title'],
      offerOn: map['offer_on'],
      offerOnId: map['offer_on_id'],
      description: map['description'],
      countdownTime: map['countdown_time'],
    );
}
