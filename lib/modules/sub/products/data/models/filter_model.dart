import '../../domain/entities/filter.dart';

class FilterModel extends Filter {
  const FilterModel({
    required List<Trade> trades,
    required Price price,
  }) : super(
          trades: trades,
          price: price,
        );
  factory FilterModel.fromJson(Map<String, dynamic> map) => FilterModel(
      trades: map.containsKey('trademarks')
          ? map['trademarks'] != null
              ? (map['trademarks'] as List)
                  .map((e) => TradeModel.fromJson(e))
                  .toList()
              : []
          : [],
      price: PriceModel.fromJson(map['price']),
    );
}

class TradeModel extends Trade {
  const TradeModel({
    required String id,
    required String value,
  }) : super(
          id: id,
          value: value,
        );
  factory TradeModel.fromJson(Map<String, dynamic> map) => TradeModel(
        id: map['id'],
        value: map['value'],
      );
}

class PriceModel extends Price {
  const PriceModel({
    required int min,
    required int max,
  }) : super(
          min: min,
          max: max,
        );
  factory PriceModel.fromJson(Map<String, dynamic> map) => PriceModel(
        min: map['min'],
        max: map['max'],
      );
}
