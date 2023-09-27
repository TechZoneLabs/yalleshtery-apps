part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetSliderBannersEvent extends HomeEvent {}

class GetOffersEvent extends HomeEvent {}

class GetHomeCategoriesEvent extends HomeEvent {
  final DataLimitation? parameter;
  const GetHomeCategoriesEvent({this.parameter});
}

class GetTrademarksEvent extends HomeEvent {
  final DataLimitation? parameter;
  const GetTrademarksEvent({this.parameter});
}

class GetLastestProductsEvent extends HomeEvent {
  final int start;
  const GetLastestProductsEvent({this.start = 0});
}

class GetBestSellerProductsEvent extends HomeEvent {
  final int start;
  const GetBestSellerProductsEvent({this.start = 0});
}

class UpdateHomeProducts extends HomeEvent {
  final String productId;
  final String quantity;
  final bool forceRest;

  const UpdateHomeProducts({
    required this.productId,
    required this.quantity,
    this.forceRest=false,
  });
}
