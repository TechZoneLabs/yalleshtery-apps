part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final Status categoryStatus;
  final List<Category> categories;
  final bool isCategoryMax;
  final Status mixSubTradeStatus;
  final MixSubTrade mixSubTrade;

  const CategoriesState({
    this.categoryStatus = Status.sleep,
    this.categories = const [],
    this.isCategoryMax = false,
    this.mixSubTradeStatus = Status.sleep,
    this.mixSubTrade = const MixSubTrade(
      subCategories: [],
      trademarks: [],
    ),
  });
  CategoriesState copyWith({
    Status? categoryStatus,
    List<Category>? categories,
    bool? isCategoryMax,
    MixSubTrade? mixSubTrade,
    Status? mixSubTradeStatus,
  }) =>
      CategoriesState(
        categoryStatus: categoryStatus ?? this.categoryStatus,
        categories: categories ?? this.categories,
        isCategoryMax: isCategoryMax ?? this.isCategoryMax,
        mixSubTradeStatus: mixSubTradeStatus ?? this.mixSubTradeStatus,
        mixSubTrade: mixSubTrade ?? this.mixSubTrade,
      );

  @override
  List<Object?> get props => [
        categoryStatus,
        categories,
        mixSubTradeStatus,
        mixSubTrade,
      ];
}
