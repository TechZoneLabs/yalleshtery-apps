import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/product.dart';
import '../repositories/base_product_repository.dart';

class GetCustomProductsUseCase
    implements BaseUseCase<Either<Failure, List<Product>>, ProductsParmeters> {
  final BaseProductRepository baseProductRepository;

  GetCustomProductsUseCase(this.baseProductRepository);
  @override
  Future<Either<Failure, List<Product>>> call(ProductsParmeters parmeters) =>
      baseProductRepository.getCustomProducts(parmeters);
}

class ProductsParmeters extends Equatable {
  final int start;
  final List ids;
  final String? searchCategoryId;
  final String? searchTrademarkId;
  final String? mode;
  final String? inStock;
  final String? minPrice;
  final String? maxPrice;
  final String? offerId;
  final String? filterType;
  final String? sort;
  final String? type;
  final String? searchKey;
  final List<dynamic> formShape;
  final List<dynamic> searchMultiPrices;

  const ProductsParmeters({
    this.start = 0,
    this.ids = const [],
    this.searchCategoryId,
    this.searchTrademarkId,
    this.mode,
    this.inStock,
    this.minPrice,
    this.maxPrice,
    this.offerId,
    this.filterType,
    this.sort,
    this.type,
    this.searchKey,
    this.formShape = const [],
    this.searchMultiPrices = const [],
  });
  ProductsParmeters copyWith({
    int? start,
    List? ids,
    String? searchCategoryId,
    String? searchTrademarkId,
    String? mode,
    String? inStock,
    String? minPrice,
    String? maxPrice,
    String? offerId,
    String? filterType,
    String? sort,
    String? type,
    String? searchKey,
    List<dynamic>? formShape,
    List<dynamic>? searchMultiPrices,
  }) =>
      ProductsParmeters(
        start: start ?? this.start,
        ids: ids ?? this.ids,
        searchCategoryId: searchCategoryId ?? this.searchCategoryId,
        searchTrademarkId: searchTrademarkId ?? this.searchTrademarkId,
        mode: mode ?? this.mode,
        inStock: inStock ?? this.inStock,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        offerId: offerId ?? this.offerId,
        filterType: filterType ?? this.filterType,
        sort: sort ?? this.sort,
        type: type ?? this.type,
        searchKey: searchKey ?? this.searchKey,
        formShape: formShape ?? this.formShape,
        searchMultiPrices: searchMultiPrices ?? this.searchMultiPrices,
      );
  @override
  List<Object?> get props => [
        searchCategoryId,
        searchTrademarkId,
        mode,
        inStock,
        minPrice,
        maxPrice,
        offerId,
        filterType,
        sort,
        type,
        searchKey,
        formShape,
        searchMultiPrices,
      ];
}
