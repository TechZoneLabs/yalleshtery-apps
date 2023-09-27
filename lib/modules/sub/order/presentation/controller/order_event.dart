part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrderEvent extends OrderEvent {
  final AddOrderParameters addOrderParameters;
  const AddOrderEvent({required this.addOrderParameters});
}

class GetOrdersEvent extends OrderEvent {
  final int start;
  const GetOrdersEvent({this.start = 0});
}

class GetOrderDetailsEvent extends OrderEvent {
  final String id;
  const GetOrderDetailsEvent({required this.id});
}

class GetUnRatedOrderEvent extends OrderEvent {}

class RateOrderEvent extends OrderEvent {
  final RateOrderParameters rateOrderParameters;
  const RateOrderEvent({required this.rateOrderParameters});
}
