part of 'order_bloc.dart';

class OrderState extends Equatable {
  final String msg;
  final Status addOrderStatus;
  final Status getOrdersStatus;
  final List<OrderEntity> orders;
  final bool isOrdersMax;
  final Status getOrderDetailsStatus;
  final OrderEntity? orderDetails;
  final Status getUnRatedOrderStatus;
  final String unRatedOrderId;
  final Status rateOrderStatus;

  const OrderState({
    this.msg = '',
    this.addOrderStatus = Status.sleep,
    this.getOrdersStatus = Status.sleep,
    this.orders = const [],
    this.isOrdersMax = false,
    this.getOrderDetailsStatus = Status.sleep,
    this.orderDetails,
    this.getUnRatedOrderStatus = Status.sleep,
    this.unRatedOrderId = '',
    this.rateOrderStatus = Status.sleep,
  });

  OrderState copyWith({
    String? msg,
    Status? addOrderStatus,
    Status? getOrdersStatus,
    List<OrderEntity>? orders,
    bool? isOrdersMax,
    Status? getOrderDetailsStatus,
    OrderEntity? orderDetails,
    Status? getUnRatedOrderStatus,
    String? unRatedOrderId,
    Status? rateOrderStatus,
  }) =>
      OrderState(
        msg: msg ?? this.msg,
        addOrderStatus: addOrderStatus ?? this.addOrderStatus,
        getOrdersStatus: getOrdersStatus ?? this.getOrdersStatus,
        orders: orders ?? this.orders,
        isOrdersMax: isOrdersMax ?? this.isOrdersMax,
        getOrderDetailsStatus:
            getOrderDetailsStatus ?? this.getOrderDetailsStatus,
        orderDetails: getOrderDetailsStatus == Status.error ||
                addOrderStatus == Status.error
            ? null
            : orderDetails ?? this.orderDetails,
        getUnRatedOrderStatus:
            getUnRatedOrderStatus ?? this.getUnRatedOrderStatus,
        unRatedOrderId: unRatedOrderId ?? this.unRatedOrderId,
        rateOrderStatus: rateOrderStatus ?? this.rateOrderStatus,
      );

  @override
  List<Object?> get props => [
        msg,
        addOrderStatus,
        getOrdersStatus,
        orders,
        isOrdersMax,
        getOrderDetailsStatus,
        orderDetails,
        getUnRatedOrderStatus,
        unRatedOrderId,
        rateOrderStatus,
      ];
}
