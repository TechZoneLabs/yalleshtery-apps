import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../../../address/domain/entities/address.dart';
import '../../../cart/domain/entities/cart.dart';
import '../entities/order.dart';
import '../repositories/base_order_repository.dart';

class AddOrderUseCase
    implements BaseUseCase<Either<Failure, bool>, AddOrderParameters> {
  final BaseOrderRepository baseOrderRepository;

  AddOrderUseCase(this.baseOrderRepository);
  @override
  Future<Either<Failure, OrderEntity>> call(AddOrderParameters parameter) =>
      baseOrderRepository.addOrder(parameter);
}

class AddOrderParameters extends Equatable {
  final Address address;
  final String cartId, note, discount;
  final List<CartProduct> items;

  const AddOrderParameters({
    required this.address,
    required this.cartId,
    required this.note,
    required this.discount,
    required this.items,
  });
  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "city_id": address.cityId,
        "city_name": address.cityName,
        "address": address.title,
        "note": note,
        'lat': address.lat,
        'lon': address.lon,
        'address_id': address.id,
        "delivery_price": address.deliveryPrice,
        "invoice_items": items
            .map((e) => {
                  'product_id': e.productId,
                  'is_gift':e.isGift,
                  'quantity': e.quantity,
                  'product_type_name': e.productTypeName,
                })
            .toList(),
        "discount": discount,
      };
  @override
  List<Object?> get props => [
        address,
        cartId,
        note,
        discount,
        items,
      ];
}
