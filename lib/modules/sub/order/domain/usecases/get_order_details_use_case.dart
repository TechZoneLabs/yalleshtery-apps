import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/order.dart';
import '../repositories/base_order_repository.dart';

class GetOrderDetailsUseCase
    implements BaseUseCase<Either<Failure, OrderEntity>, String> {
  final BaseOrderRepository baseOrderRepository;

  GetOrderDetailsUseCase(this.baseOrderRepository);
  @override
  Future<Either<Failure, OrderEntity>> call(String id) =>
      baseOrderRepository.getOrderDetails(id);
}
