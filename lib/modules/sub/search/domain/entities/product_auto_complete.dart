import 'package:equatable/equatable.dart';

class ProductAutoCompleteData extends Equatable {
  final List<ProductAutoComplete> data;
  final int totalCount;

  const ProductAutoCompleteData({
    required this.data,
    required this.totalCount,
  });

  @override
  List<Object?> get props => [
        data,
        totalCount,
      ];
}

class ProductAutoComplete extends Equatable {
  final String id;
  final String name;
  final String price;
  final String? lastPrice;
  final String image;
  final int storeAmounts;
  final dynamic affiliatorCommission;

  const ProductAutoComplete({
    required this.id,
    required this.name,
    required this.price,
    this.lastPrice,
    required this.image,
    required this.storeAmounts,
    this.affiliatorCommission,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        lastPrice,
        image,
        storeAmounts,
        affiliatorCommission,
      ];
}
