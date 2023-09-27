import '../../domain/entities/product_auto_complete.dart';

class ProductAutoCompleteDataModel extends ProductAutoCompleteData {
  const ProductAutoCompleteDataModel({
    required List<ProductAutoComplete> data,
    required int totalCount,
  }) : super(
          data: data,
          totalCount: totalCount,
        );
  factory ProductAutoCompleteDataModel.fromJson(Map<String, dynamic> map) =>
      ProductAutoCompleteDataModel(
        data: map.containsKey('data')
            ? (map['data'] as List)
                .map((e) => ProductAutoCompleteModel.fromJson(e))
                .toList()
            : [],
        totalCount: map.containsKey('total_count') ? map['total_count'] : 0,
      );
}

class ProductAutoCompleteModel extends ProductAutoComplete {
  const ProductAutoCompleteModel({
    required String id,
    required String name,
    required String price,
    String? lastPrice,
    required String image,
    required int storeAmounts,
    dynamic affiliatorCommission,
  }) : super(
          id: id,
          name: name,
          price: price,
          lastPrice: lastPrice,
          image: image,
          storeAmounts: storeAmounts,
          affiliatorCommission: affiliatorCommission,
        );
  factory ProductAutoCompleteModel.fromJson(Map<String, dynamic> map) =>
      ProductAutoCompleteModel(
        id: map['id'],
        price: map['price_one'],
        lastPrice: map['last_price'],
        name: map['name'],
        image: map['image'],
        storeAmounts: map['store_amounts'],
        affiliatorCommission: map['affiliator_commission'],
      );
}
