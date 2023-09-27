part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartDataEvent extends CartEvent {
  final bool update;
  final bool forceRest;

  const GetCartDataEvent({
    this.update = false,
    this.forceRest = false,
  });
}

class AddItemEvent extends CartEvent {
  final AddItemParameters addItemParameters;
  const AddItemEvent({required this.addItemParameters});
}

class UpdateItemEvent extends CartEvent {
  final bool fromCart;
  final UpdateItemParameters updateItemParameters;
  const UpdateItemEvent({
    required this.updateItemParameters,
    required this.fromCart,
  });
}

class DeleteItemEvent extends CartEvent {
  final String id;
  final String productId;
  const DeleteItemEvent({
    required this.id,
    required this.productId,
  });
}

class EmptyCartEvent extends CartEvent {
  final bool withoutEmit;
  const EmptyCartEvent({this.withoutEmit = false});
}

class CheckPromoEvent extends CartEvent {
  final PromoParameters promoParameters;
  const CheckPromoEvent({required this.promoParameters});
}

class DeletePromoEvent extends CartEvent {
  final String couponId;
  const DeletePromoEvent({required this.couponId});
}
