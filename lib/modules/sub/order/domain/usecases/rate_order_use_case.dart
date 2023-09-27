import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_order_repository.dart';

class RateOrderUseCase
    implements BaseUseCase<Either<Failure, bool>, RateOrderParameters> {
  final BaseOrderRepository baseOrderRepository;

  RateOrderUseCase(this.baseOrderRepository);
  @override
  Future<Either<Failure, bool>> call(RateOrderParameters parameters) =>
      baseOrderRepository.rateOrder(parameters);
}

class RateOrderParameters extends Equatable {
  final String mode, orderId, rateNotes;
  final double rateVal;
  const RateOrderParameters({
    required this.mode,
    required this.orderId,
    required this.rateVal,
    required this.rateNotes,
  });
  Map<String, dynamic> toJson() => {
        'mode_id': orderId,
        'mode': mode,
        'value': rateVal,
        'note': rateNotes,
      };
  @override
  List<Object?> get props => [
        mode,
        orderId,
        rateVal,
        rateNotes,
      ];
}
