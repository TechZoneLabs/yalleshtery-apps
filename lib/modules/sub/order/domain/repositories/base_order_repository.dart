import 'package:dartz/dartz.dart';

import '../../../../../app/errors/failure.dart';
import '../entities/order.dart';
import '../usecases/add_order_use_case.dart';
import '../usecases/rate_order_use_case.dart';

abstract class BaseOrderRepository {
  Future<Either<Failure, OrderEntity>> addOrder(AddOrderParameters addOrderParameters);
  Future<Either<Failure, List<OrderEntity>>> getOrders(int start);
  Future<Either<Failure, OrderEntity>> getOrderDetails(String id);
  Future<Either<Failure, String>> getUnRatedOrder();
  Future<Either<Failure, bool>> rateOrder(RateOrderParameters rateOrderParameters);
}
