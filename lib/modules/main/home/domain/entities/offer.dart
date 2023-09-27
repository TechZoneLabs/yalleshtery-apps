import 'package:equatable/equatable.dart';

class OfferType extends Equatable {
  final List<OfferData> inSlider;
  final List<OfferData> inCategories;
  final List<OfferData> inLastProducts;
  final List<OfferData> inTrademarks;

  const OfferType({
    required this.inSlider,
    required this.inCategories,
    required this.inLastProducts,
    required this.inTrademarks,
  });

  @override
  List<Object?> get props => [
        inSlider,
        inCategories,
        inTrademarks,
        inLastProducts,
      ];
}

class OfferData extends Equatable {
  final String id;
  final String priority;
  final String offerStartDate;
  final String? offerEndDate;
  final String offerType;
  final String priceType;
  final String offerWidth;
  final String showOn;
  final String showOnPlaces;
  final String active;
  final String image;
  final String adminId;
  final String affiliatorId;
  final String sort;
  final String dateAdded;
  final String title;
  final String offerOn;
  final String offerOnId;
  final dynamic description;
  final dynamic countdownTime;

  const OfferData({
    required this.id,
    required this.priority,
    required this.offerStartDate,
    this.offerEndDate,
    required this.offerType,
    required this.priceType,
    required this.offerWidth,
    required this.showOn,
    required this.showOnPlaces,
    required this.active,
    required this.image,
    required this.adminId,
    required this.affiliatorId,
    required this.sort,
    required this.dateAdded,
    required this.title,
    required this.offerOn,
    required this.offerOnId,
    required this.description,
    required this.countdownTime,
  });
  OfferData copyWith({String? offerWidth}) => OfferData(
        id: id,
        priority: priority,
        offerStartDate: offerStartDate,
        offerEndDate: offerEndDate,
        offerType: offerType,
        priceType: priceType,
        offerWidth: offerWidth ?? this.offerWidth,
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
  @override
  List<Object?> get props => [
        id,
        priority,
        offerStartDate,
        offerEndDate,
        offerType,
        priceType,
        offerWidth,
        showOn,
        showOnPlaces,
        active,
        image,
        adminId,
        affiliatorId,
        sort,
        dateAdded,
        title,
        offerOn,
        offerOnId,
        description,
        countdownTime,
      ];
}
