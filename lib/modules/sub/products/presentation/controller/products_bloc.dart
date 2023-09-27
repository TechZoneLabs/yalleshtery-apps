import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/errors/failure.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_listen_to_product_use_case.dart';
import '../../domain/usecases/get_filters_use_case.dart';
import '../../domain/usecases/get_product_details_use_case.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetCustomProductsUseCase getCustomProductsUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final GetFiltersUseCase getFiltersUseCase;
  final AddListenToProductUseCase addListenToProductUseCase;

  ProductsBloc({
    required this.getCustomProductsUseCase,
    required this.getProductDetailsUseCase,
    required this.getFiltersUseCase,
    required this.addListenToProductUseCase,
  }) : super(const ProductsState()) {
    on<GetProductDetailsEvent>(_getProductDetails);
    on<GetCustomProductsEvent>(_getCustomProducts);
    on<GetFiltersEvent>(_getFilters);
    on<AddListenToProductEvent>(_addListenToProduct);
    on<UpdateProductDetailsEvent>(_updateProductDetails);
    on<UpdateCustomProductEvent>(_updateCustomProducts);
  }

  FutureOr<void> _getProductDetails(
      GetProductDetailsEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(
      productDetailsStatus: Status.loading,
      productDetails: null,
    ));
    Either<Failure, Product> result =
        await getProductDetailsUseCase(event.productDetailsParmeters);
    result.fold(
      (failure) => emit(state.copyWith(
        productDetailsStatus: Status.error,
        productDetails: null,
      )),
      (prod) => emit(
        state.copyWith(
          productDetailsStatus: Status.loaded,
          productDetails: prod,
        ),
      ),
    );
  }

  FutureOr<void> _getCustomProducts(
      GetCustomProductsEvent event, Emitter<ProductsState> emit) async {
    if (!state.isCustomProdMax || event.productsParmeters.start == 0) {
      emit(
        state.copyWith(
          customProdStatus: event.productsParmeters.start == 0
              ? Status.initial
              : Status.loading,
          customProds:
              event.productsParmeters.start == 0 ? [] : state.customProds,
        ),
      );
      Either<Failure, List<Product>> result =
          await getCustomProductsUseCase(event.productsParmeters);
      result.fold(
        (failure) => emit(state.copyWith(
            customProdStatus: Status.error, customProds: state.customProds)),
        (prods) => emit(
          state.copyWith(
            customProdStatus: Status.loaded,
            customProds: List.from(state.customProds)..addAll(prods),
            isCustomProdMax: prods.length < 10,
          ),
        ),
      );
    }
  }

  FutureOr<void> _getFilters(
      GetFiltersEvent event, Emitter<ProductsState> emit) async {
    emit(
      state.copyWith(
        filtersStatus: Status.loading,
      ),
    );
    Either<Failure, Filter> result =
        await getFiltersUseCase(event.productsParmeters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          filtersStatus: Status.error,
          filters: null,
        ),
      ),
      (filters) => emit(
        state.copyWith(
          filtersStatus: Status.loaded,
          filters: filters,
        ),
      ),
    );
  }

  FutureOr<void> _addListenToProduct(
      AddListenToProductEvent event, Emitter<ProductsState> emit) async {
    emit(
      state.copyWith(
        productListenStatus: Status.loading,
      ),
    );
    var result = await addListenToProductUseCase(event.listenProductParameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          productListenStatus: Status.error,
          productListenIsAdded: false,
        ),
      ),
      (val) => emit(
        state.copyWith(
          productListenStatus: Status.loaded,
          productListenIsAdded: val,
        ),
      ),
    );
  }

  FutureOr<void> _updateProductDetails(
      UpdateProductDetailsEvent event, Emitter<ProductsState> emit) {
    emit(state.copyWith(productDetailsStatus: Status.updating));
    emit(
      state.copyWith(
        productDetailsStatus: Status.updated,
        productDetails: state.productDetails?.id == event.productId
            ? state.productDetails?.copyWith(quantityInCart: event.quantity)
            : state.productDetails,
      ),
    );
  }

  FutureOr<void> _updateCustomProducts(
      UpdateCustomProductEvent event, Emitter<ProductsState> emit) {
    emit(state.copyWith(customProdStatus: Status.updating));
    emit(
      state.copyWith(
        customProdStatus: Status.updated,
        customProds: state.customProds
            .map((e) => event.forceRest
                ? e.copyWith(quantityInCart: '0')
                : e.id == event.productId
                    ? e.copyWith(quantityInCart: event.quantity)
                    : e)
            .toList(),
      ),
    );
  }
}
