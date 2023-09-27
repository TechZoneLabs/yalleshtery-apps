part of 'home_bloc.dart';

class HomeState extends Equatable {
  final Status sliderBannerStatus;
  final List<SliderBanner> sliderBannersList;
  final Status offerTypeStatus;
  final OfferType offerType;
  final Status categoryStatus;
  final List<Category> categories;
  final bool isCategoryMax;
  final Status trademarkStatus;
  final List<Trademark> trademarks;
  final bool isTrademarkMax;
  final Status lastestProdStatus;
  final List<Product> lastestProds;
  final bool isLastestProdMax;
  final Status bestSellerProdStatus;
  final List<Product> bestSellerProds;
  final bool isBestSellerProdMax;

  const HomeState({
    this.sliderBannerStatus = Status.sleep,
    this.sliderBannersList = const [],
    this.offerTypeStatus = Status.sleep,
    this.offerType = const OfferType(
      inCategories: [],
      inLastProducts: [],
      inSlider: [],
      inTrademarks: [],
    ),
    this.categoryStatus = Status.sleep,
    this.categories = const [],
    this.isCategoryMax = false,
    this.trademarkStatus = Status.sleep,
    this.trademarks = const [],
    this.isTrademarkMax = false,
    this.lastestProdStatus = Status.sleep,
    this.lastestProds = const [],
    this.isLastestProdMax = false,
    this.bestSellerProdStatus = Status.sleep,
    this.bestSellerProds = const [],
    this.isBestSellerProdMax = false,
  });
  HomeState copyWith({
    Status? sliderBannerStatus,
    List<SliderBanner>? sliderBannersList,
    Status? offerTypeStatus,
    OfferType? offerType,
    Status? categoryStatus,
    List<Category>? categories,
    bool? isCategoryMax,
    Status? trademarkStatus,
    List<Trademark>? trademarks,
    bool? isTrademarkMax,
    Status? lastestProdStatus,
    List<Product>? lastestProds,
    bool? isLastestProdMax,
    Status? bestSellerProdStatus,
    List<Product>? bestSellerProds,
    bool? isBestSellerProdMax,
  }) =>
      HomeState(
        sliderBannerStatus: sliderBannerStatus ?? this.sliderBannerStatus,
        sliderBannersList: sliderBannersList ?? this.sliderBannersList,
        offerTypeStatus: offerTypeStatus ?? this.offerTypeStatus,
        offerType: offerType ?? this.offerType,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        categories: categories ?? this.categories,
        isCategoryMax: isCategoryMax ?? this.isCategoryMax,
        trademarkStatus: trademarkStatus ?? this.trademarkStatus,
        trademarks: trademarks ?? this.trademarks,
        isTrademarkMax: isTrademarkMax ?? this.isTrademarkMax,
        lastestProdStatus: lastestProdStatus ?? this.lastestProdStatus,
        lastestProds: lastestProds ?? this.lastestProds,
        isLastestProdMax: isLastestProdMax ?? this.isLastestProdMax,
        bestSellerProdStatus: bestSellerProdStatus ?? this.bestSellerProdStatus,
        bestSellerProds: bestSellerProds ?? this.bestSellerProds,
        isBestSellerProdMax: isBestSellerProdMax ?? this.isBestSellerProdMax,
      );

  @override
  List<Object?> get props => [
        sliderBannerStatus,
        sliderBannersList,
        offerTypeStatus,
        offerType,
        categoryStatus,
        categories,
        trademarkStatus,
        trademarks,
        lastestProds,
        lastestProdStatus,
        bestSellerProdStatus,
        bestSellerProds,
      ];
}
