import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/order.dart';
import '../repositories/base_order_repository.dart';

class GetOrdersUseCase
    implements BaseUseCase<Either<Failure, List<OrderEntity>>, int> {
  final BaseOrderRepository baseOrderRepository;

  GetOrdersUseCase(this.baseOrderRepository);
  @override
  Future<Either<Failure, List<OrderEntity>>> call(int start) =>
      baseOrderRepository.getOrders(start);
}
