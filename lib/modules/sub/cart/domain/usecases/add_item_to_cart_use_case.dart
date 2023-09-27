import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_cart_repository.dart';

class AddItemToCartUseCase
    implements BaseUseCase<Either<Failure, bool>, AddItemParameters> {
  final BaseCartRepository baseCartRepository;

  AddItemToCartUseCase(this.baseCartRepository);
  @override
  Future<Either<Failure, bool>> call(AddItemParameters parameters) =>
      baseCartRepository.addItemToCart(parameters);
}

class AddItemParameters extends Equatable {
  final String productId;
  final int quantity;
  final String productTypeName;
  final String offerId;

  const AddItemParameters({
    required this.productId,
    required this.quantity,
    required this.productTypeName,
    required this.offerId,
  });

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'quantity': quantity,
        'product_type_name': productTypeName,
        'offer_id': offerId,
      };

  @override
  List<Object?> get props => [
        productId,
        quantity,
        productTypeName,
        offerId,
      ];
}
