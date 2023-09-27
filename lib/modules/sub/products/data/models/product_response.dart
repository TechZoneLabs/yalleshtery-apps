import 'product_model.dart';

class ProductsResponse {
  final bool success;
  final List<ProductModel> data;
  final String? message;

  ProductsResponse({
    required this.success,
    required this.data,
    required this.message,
  });
  factory ProductsResponse.fromJson(Map<String, dynamic> map) =>
      ProductsResponse(
          success: map['success'],
          data: map.containsKey('data')
              ? (map['data'] as List)
                  .map((e) => ProductModel.fromJson(e))
                  .toList()
              : [],
          message: map.containsKey('message') ? map['message'] : null);
}

class ProductResponse {
  final bool success;
  final ProductModel data;
  final String? message;

  ProductResponse({
    required this.success,
    required this.data,
    required this.message,
  });
  factory ProductResponse.fromJson(Map<String, dynamic> map) => ProductResponse(
      success: map['success'],
      data: ProductModel.fromJson(map['data']),
      message: map.containsKey('message') ? map['message'] : null);
}
