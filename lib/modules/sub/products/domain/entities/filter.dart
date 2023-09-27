import 'package:equatable/equatable.dart';

class Filter extends Equatable {
  final List<Trade> trades;
  final Price price;

  const Filter({required this.trades, required this.price});

  @override
  List<Object?> get props => [trades, price];
}

class Trade extends Equatable {
  final String id;
  final String value;

  final bool selected;
  final int selectCount;
  const Trade({
    required this.id,
    required this.value,
    this.selected = false,
    this.selectCount = 0,
  });
  Trade copyWith({bool? selected, int? selectCount}) => Trade(
        id: id,
        value: value,
        selected: selected ?? this.selected,
        selectCount: selectCount ?? this.selectCount,
      );
  @override
  List<Object?> get props => [
        id,
        value,
        selected,
        selectCount,
      ];
}

class Price extends Equatable {
  final int min;
  final int max;
  final bool selected;

  const Price({
    required this.min,
    required this.max,
    this.selected = false,
  });
  Price copyWith(bool? selected) => Price(
        min: min,
        max: max,
        selected: selected ?? this.selected,
      );
  @override
  List<Object?> get props => [
        min,
        min,
        selected,
      ];
}
