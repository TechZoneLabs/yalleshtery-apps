import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_order_repository.dart';

class GetUnRatedOrderUseCase
    implements BaseUseCase<Either<Failure, String>, NoParameters> {
  final BaseOrderRepository baseOrderRepository;

  GetUnRatedOrderUseCase(this.baseOrderRepository);
  @override
  Future<Either<Failure, String>> call(_) =>
      baseOrderRepository.getUnRatedOrder();
}
