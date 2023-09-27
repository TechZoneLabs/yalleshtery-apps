part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends CategoriesEvent {
  final DataLimitation? parameter;
  const GetCategoriesEvent({this.parameter});
}

class GetMixSubTradeEvent extends CategoriesEvent {
  final int categoryId;
  const GetMixSubTradeEvent({required this.categoryId});
}
