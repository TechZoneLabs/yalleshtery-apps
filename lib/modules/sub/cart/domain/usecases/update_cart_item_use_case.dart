import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_cart_repository.dart';

class UpdateCartItemUseCase
    implements BaseUseCase<Either<Failure, bool>, UpdateItemParameters> {
  final BaseCartRepository baseCartRepository;

  UpdateCartItemUseCase(this.baseCartRepository);
  @override
  Future<Either<Failure, bool>> call(UpdateItemParameters parameters) =>
      baseCartRepository.updateCartItem(parameters);
}

class UpdateItemParameters extends Equatable {
  final String id;
  final int quantity;

  const UpdateItemParameters({
    required this.id,
    required this.quantity,
  });
  Map<String, dynamic> toJson() => {
        'key': id,
        'quantity': quantity,
      };
  @override
  List<Object?> get props => [
        id,
        quantity,
      ];
}
