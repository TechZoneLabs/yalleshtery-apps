import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/cart.dart';
import '../../domain/usecases/add_item_to_cart_use_case.dart';
import '../../domain/usecases/check_promo_use_case.dart';
import '../../domain/usecases/delete_cart_item_use_case.dart';
import '../../domain/usecases/delete_promo_use_case.dart';
import '../../domain/usecases/empty_cart_use_case.dart';
import '../../domain/usecases/get_cart_data_use_case.dart';
import '../../domain/usecases/update_cart_item_use_case.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartDataUseCase getCartDataUseCase;
  final AddItemToCartUseCase addItemToCartUseCase;
  final UpdateCartItemUseCase updateCartItemUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;
  final EmptyCartUseCase emptyCartUseCase;
  final CheckPromoUseCase checkPromoUseCase;
  final DeletePromoUseCase deletePromoUseCase;

  CartBloc({
    required this.getCartDataUseCase,
    required this.addItemToCartUseCase,
    required this.updateCartItemUseCase,
    required this.deleteCartItemUseCase,
    required this.emptyCartUseCase,
    required this.checkPromoUseCase,
    required this.deletePromoUseCase,
  }) : super(const CartState()) {
    on<GetCartDataEvent>(_getCartData);
    on<AddItemEvent>(_addItem);
    on<UpdateItemEvent>(_updateItem);
    on<DeleteItemEvent>(_deleteItem);
    on<EmptyCartEvent>(_emptyCart);
    on<CheckPromoEvent>(_checkPromo);
    on<DeletePromoEvent>(_deletePromo);
  }

  FutureOr<void> _getCartData(
      GetCartDataEvent event, Emitter<CartState> emit) async {
    emit(
      state.copyWith(
        cartStatus: event.update ? Status.updating : Status.loading,
        addItemStatus: Status.sleep,
        updateItemStatus: Status.sleep,
        deleteItemStatus: Status.sleep,
        emptyCartStatus: Status.sleep,
        promoStatus: Status.sleep,
      ),
    );
    Either<Failure, Cart> result =
        await getCartDataUseCase(const NoParameters());
    result.fold(
      (_) => emit(
        state.copyWith(
          cartStatus: Status.error,
          cart: event.forceRest ? null : state.cart,
          cartNum: event.forceRest ? '0' : state.cartNum,
        ),
      ),
      (cart) => emit(
        state.copyWith(
          cartStatus: event.update ? Status.updated : Status.loaded,
          cart: cart,
          cartNum: cart.totalProductCount.toString(),
          couponInfo: state.couponInfo ?? cart.couponInfo,
        ),
      ),
    );
  }

  FutureOr<void> _addItem(AddItemEvent event, Emitter<CartState> emit) async {
    emit(
      state.copyWith(
        addItemStatus: Status.loading,
      ),
    );
    Either<Failure, bool> result =
        await addItemToCartUseCase(event.addItemParameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addItemStatus: Status.error,
        ),
      ),
      (val) => emit(
        state.copyWith(
          addItemStatus: Status.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _updateItem(
      UpdateItemEvent event, Emitter<CartState> emit) async {
    emit(
      event.fromCart
          ? state.copyWith(
              promoStatus: Status.sleep,
              updateItemStatus: Status.updating,
              cartStatus: Status.loaded,
              cart: state.cart == null
                  ? null
                  : state.cart!.copyWith(
                      items: state.cart!.items
                          .map(
                            (e) => event.updateItemParameters.id == e.productId
                                ? e.copyWith(
                                    hasLoading: true,
                                  )
                                : e,
                          )
                          .toList(),
                    ),
            )
          : state.copyWith(
              promoStatus: Status.sleep,
              updateItemStatus: Status.updating,
              cartStatus: Status.sleep,
            ),
    );
    Either<Failure, bool> result =
        await updateCartItemUseCase(event.updateItemParameters);
    result.fold(
      (failure) => emit(
        event.fromCart
            ? state.copyWith(
                updateItemStatus: Status.error,
                cart: state.cart == null
                    ? null
                    : state.cart!.copyWith(
                        items: state.cart!.items
                            .map(
                              (e) =>
                                  event.updateItemParameters.id == e.productId
                                      ? e.copyWith(hasLoading: false)
                                      : e,
                            )
                            .toList(),
                      ),
              )
            : state.copyWith(
                updateItemStatus: Status.error,
              ),
      ),
      (val) => emit(
        event.fromCart
            ? state.copyWith(
                updateItemStatus: Status.updated,
                cartStatus: Status.sleep,
                cart: state.cart == null
                    ? null
                    : state.cart!.copyWith(
                        items: state.cart!.items
                            .map(
                              (e) =>
                                  event.updateItemParameters.id == e.productId
                                      ? e.copyWith(
                                          hasLoading: false,
                                          quantity: event
                                              .updateItemParameters.quantity
                                              .toString(),
                                        )
                                      : e,
                            )
                            .toList(),
                      ),
              )
            : state.copyWith(
                updateItemStatus: Status.updated,
              ),
      ),
    );
  }

  FutureOr<void> _deleteItem(
      DeleteItemEvent event, Emitter<CartState> emit) async {
    emit(
      state.copyWith(
        deleteItemStatus: Status.loading,
        emptyCartStatus: Status.sleep,
        cartStatus: Status.sleep,
        promoStatus: Status.sleep,
      ),
    );
    Either<Failure, bool> result = await deleteCartItemUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteItemStatus: Status.error,
          deleteItemProdId: '',
          msg: failure.msg,
        ),
      ),
      (_) => emit(
        state.copyWith(
          deleteItemStatus: Status.loaded,
          deleteItemProdId: event.productId,
        ),
      ),
    );
  }

  FutureOr<void> _emptyCart(
      EmptyCartEvent event, Emitter<CartState> emit) async {
    if (event.withoutEmit) {
      emptyCartUseCase(const NoParameters());
    } else {
      emit(
        state.copyWith(
          emptyCartStatus: Status.loading,
          cartStatus: Status.sleep,
          deleteItemStatus: Status.sleep,
          promoStatus: Status.sleep,
        ),
      );
      Either<Failure, bool> result =
          await emptyCartUseCase(const NoParameters());
      result.fold(
        (failure) => emit(
          state.copyWith(
            emptyCartStatus: Status.error,
            msg: failure.msg,
          ),
        ),
        (_) => emit(
          state.copyWith(
            emptyCartStatus: Status.loaded,
          ),
        ),
      );
    }
  }

  FutureOr<void> _checkPromo(
      CheckPromoEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      promoStatus: Status.loading,
      cartStatus: Status.sleep,
    ));
    Either<Failure, CouponInfo> result =
        await checkPromoUseCase(event.promoParameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          promoStatus: Status.error,
          couponInfo: null,
          msg: failure.msg,
        ),
      ),
      (couponInfo) => emit(
        state.copyWith(
          promoStatus: Status.loaded,
          couponInfo: couponInfo,
        ),
      ),
    );
  }

  FutureOr<void> _deletePromo(
      DeletePromoEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      promoStatus: Status.loading,
      cartStatus: Status.sleep,
    ));
    Either<Failure, bool> result = await deletePromoUseCase(event.couponId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          promoStatus: Status.error,
          msg: failure.msg,
        ),
      ),
      (_) => emit(
        state.copyWith(
          promoStatus: Status.loaded,
          couponInfo: null,
        ),
      ),
    );
  }
}
