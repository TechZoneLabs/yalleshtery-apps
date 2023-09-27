import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_product_repository.dart';

class AddListenToProductUseCase
    implements BaseUseCase<Either<Failure, bool>, ListenProductParameters> {
  final BaseProductRepository baseProductRepository;

  AddListenToProductUseCase(this.baseProductRepository);
  @override
  Future<Either<Failure, bool>> call(ListenProductParameters parameters) =>
      baseProductRepository.addListenToProductAvailability(parameters);
}

class ListenProductParameters extends Equatable {
  final String productId;
  final String note;

  const ListenProductParameters({required this.productId, this.note = '',});
  
  @override
  List<Object?> get props => [productId,note,];
}
