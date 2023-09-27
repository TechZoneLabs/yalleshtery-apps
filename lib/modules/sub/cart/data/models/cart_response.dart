import 'cart_model.dart';

class CartResponse {
  final bool success;
  final CartModel? data;

  CartResponse({
    required this.success,
    required this.data,
  });
  factory CartResponse.fromJson(Map<String, dynamic> map) => CartResponse(
        success: map['success'],
        data: map.containsKey('data') ? CartModel.fromJson(map['data']) : null,
      );
}
