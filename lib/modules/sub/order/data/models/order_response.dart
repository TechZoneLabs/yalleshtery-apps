import 'order_model.dart';

class OrderResponse {
  final bool success;
  final List<OrderModel> orders;
  final OrderModel? orderDetails;

  OrderResponse({
    required this.success,
    this.orders = const [],
    this.orderDetails,
  });
  factory OrderResponse.fromJson(Map<String, dynamic> map) {
    bool containData = map.containsKey('data');
    bool dataHasList = containData ? map['data'] is List : false;
    return dataHasList
        ? OrderResponse(
            success: map['success'],
            orders: (map['data'] as List)
                .map((e) => OrderModel.fromJson(e))
                .toList(),
          )
        : OrderResponse(
            success: map['success'],
            orderDetails: containData ? OrderModel.fromJson(map['data']) : null,
          );
  }
}
