part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetailsEvent extends ProductsEvent {
  final ProductDetailsParmeters productDetailsParmeters;
  const GetProductDetailsEvent({required this.productDetailsParmeters});
}

class GetCustomProductsEvent extends ProductsEvent {
  final ProductsParmeters productsParmeters;
  const GetCustomProductsEvent({
    required this.productsParmeters,
  });
}

class GetFiltersEvent extends ProductsEvent {
  final ProductsParmeters productsParmeters;
  const GetFiltersEvent({
    required this.productsParmeters,
  });
}

class AddListenToProductEvent extends ProductsEvent {
  final ListenProductParameters listenProductParameters;
  const AddListenToProductEvent({
    required this.listenProductParameters,
  });
}

class UpdateProductDetailsEvent extends ProductsEvent {
  final String productId;
  final String quantity;

  const UpdateProductDetailsEvent({
    required this.productId,
    required this.quantity,
  });
}

class UpdateCustomProductEvent extends ProductsEvent {
  final String productId;
  final String quantity;
  final bool forceRest;

  const UpdateCustomProductEvent({
    required this.productId,
    required this.quantity,
    this.forceRest = false,
  });
}
