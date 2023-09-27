part of 'brands_bloc.dart';

class BrandsState extends Equatable {
  final Status trademarkStatus;
  final List<Trademark> trademarks;
  final bool isTrademarkMax;

  const BrandsState({
    this.trademarkStatus = Status.sleep,
    this.trademarks = const [],
    this.isTrademarkMax = false,
  });
  BrandsState copyWith({
    Status? trademarkStatus,
    List<Trademark>? trademarks,
    bool? isTrademarkMax,
  }) =>
      BrandsState(
        trademarkStatus: trademarkStatus ?? this.trademarkStatus,
        trademarks: trademarks ?? this.trademarks,
        isTrademarkMax: isTrademarkMax ?? this.isTrademarkMax,
      );

  @override
  List<Object?> get props => [
        trademarkStatus,
        trademarks,
        isTrademarkMax,
      ];
}
