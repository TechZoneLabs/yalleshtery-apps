import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/add_order_use_case.dart';
import '../../domain/usecases/get_order_details_use_case.dart';
import '../../domain/usecases/get_orders_use_case.dart';
import '../../domain/usecases/get_un_rated_order_use_case.dart';
import '../../domain/usecases/rate_order_use_case.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final AddOrderUseCase addOrderUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final GetUnRatedOrderUseCase getUnRatedOrderUseCase;
  final RateOrderUseCase rateOrderUseCase;
  OrderBloc({
    required this.addOrderUseCase,
    required this.getOrdersUseCase,
    required this.getOrderDetailsUseCase,
    required this.getUnRatedOrderUseCase,
    required this.rateOrderUseCase,
  }) : super(const OrderState()) {
    on<AddOrderEvent>(_addOrder);
    on<GetOrdersEvent>(_getOrders);
    on<GetOrderDetailsEvent>(_getOrderDetails);
    on<GetUnRatedOrderEvent>(_getUnRatedOrder);
    on<RateOrderEvent>(_rateOrder);
  }

  FutureOr<void> _addOrder(
      AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        addOrderStatus: Status.loading,
      ),
    );
    Either<Failure, OrderEntity> result =
        await addOrderUseCase(event.addOrderParameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addOrderStatus: Status.error,
          msg: failure.msg,
        ),
      ),
      (orderDetails) => emit(
        state.copyWith(
          addOrderStatus: Status.loaded,
          orderDetails: orderDetails,
        ),
      ),
    );
  }

  FutureOr<void> _getOrders(
      GetOrdersEvent event, Emitter<OrderState> emit) async {
    bool init = event.start == 0;
    if (init || !state.isOrdersMax) {
      emit(
        state.copyWith(
          getOrdersStatus: init ? Status.initial : Status.loading,
          orders: init ? [] : state.orders,
        ),
      );
      Either<Failure, List<OrderEntity>> result =
          await getOrdersUseCase(event.start);
      result.fold(
        (failure) => emit(
          state.copyWith(
            getOrdersStatus: Status.error,
            orders: init ? [] : state.orders,
            isOrdersMax: init ? false : true,
          ),
        ),
        (orders) => emit(
          state.copyWith(
            getOrdersStatus: Status.loaded,
            orders: List.from(state.orders)..addAll(orders),
            isOrdersMax: orders.length < 10,
          ),
        ),
      );
    }
  }

  FutureOr<void> _getOrderDetails(
      GetOrderDetailsEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        getOrderDetailsStatus: Status.loading,
      ),
    );
    Either<Failure, OrderEntity> result =
        await getOrderDetailsUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getOrderDetailsStatus: Status.error,
          orderDetails: null,
        ),
      ),
      (orderDetails) => emit(
        state.copyWith(
          getOrderDetailsStatus: Status.loaded,
          orderDetails: orderDetails,
        ),
      ),
    );
  }

  FutureOr<void> _getUnRatedOrder(
      GetUnRatedOrderEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        getUnRatedOrderStatus: Status.loading,
        rateOrderStatus: Status.sleep,
      ),
    );
    Either<Failure, String> result =
        await getUnRatedOrderUseCase(const NoParameters());
    result.fold(
      (failure) => emit(
        state.copyWith(
          getUnRatedOrderStatus: Status.error,
          unRatedOrderId: '',
        ),
      ),
      (val) => emit(
        state.copyWith(
          getUnRatedOrderStatus: Status.loaded,
          unRatedOrderId: val,
        ),
      ),
    );
  }

  FutureOr<void> _rateOrder(
      RateOrderEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        rateOrderStatus: Status.loading,
        getUnRatedOrderStatus: Status.sleep,
      ),
    );
    Either<Failure, bool> result =
        await rateOrderUseCase(event.rateOrderParameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          rateOrderStatus: Status.error,
          msg: failure.msg,
        ),
      ),
      (_) => emit(
        state.copyWith(
          rateOrderStatus: Status.loaded,
        ),
      ),
    );
  }
}
