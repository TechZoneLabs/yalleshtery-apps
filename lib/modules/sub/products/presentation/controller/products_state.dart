part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final Status productDetailsStatus;
  final Product? productDetails;
  final Status customProdStatus;
  final List<Product> customProds;
  final bool isCustomProdMax;
  final Status filtersStatus;
  final Filter filters;
  final Status productListenStatus;
  final bool productListenIsAdded;
  const ProductsState({
    this.productDetailsStatus = Status.sleep,
    this.productDetails,
    this.customProdStatus = Status.sleep,
    this.customProds = const [],
    this.isCustomProdMax = false,
    this.filtersStatus = Status.sleep,
    this.filters = const Filter(
      trades: [],
      price: Price(
        max: 0,
        min: 0,
      ),
    ),
    this.productListenStatus = Status.sleep,
    this.productListenIsAdded = false,
  });
  ProductsState copyWith({
    Status? productDetailsStatus,
    Product? productDetails,
    Status? customProdStatus,
    List<Product>? customProds,
    bool? isCustomProdMax,
    Status? filtersStatus,
    Filter? filters,
    Status? productListenStatus,
    bool? productListenIsAdded,
  }) =>
      ProductsState(
        productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
        productDetails: productDetailsStatus == Status.error
            ? null
            : productDetails ?? this.productDetails,
        customProdStatus: customProdStatus ?? this.customProdStatus,
        customProds: customProds ?? this.customProds,
        isCustomProdMax: isCustomProdMax ?? this.isCustomProdMax,
        filtersStatus: filtersStatus ?? this.filtersStatus,
        filters: filters ?? this.filters,
        productListenStatus: productListenStatus ?? this.productListenStatus,
        productListenIsAdded: productListenIsAdded ?? this.productListenIsAdded,
      );

  @override
  List<Object?> get props => [
        productDetailsStatus,
        productDetails,
        customProdStatus,
        customProds,
        isCustomProdMax,
        filtersStatus,
        filters,
        productListenStatus,
        productListenIsAdded,
      ];
}
