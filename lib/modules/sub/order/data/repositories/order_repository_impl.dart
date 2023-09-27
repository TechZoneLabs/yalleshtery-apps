import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/services/network_services.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/base_order_repository.dart';
import '../../domain/usecases/add_order_use_case.dart';
import '../../domain/usecases/rate_order_use_case.dart';
import '../datasources/remote_data_source.dart';

class OrderRepositoryImpl implements BaseOrderRepository {
  final BaseOrderRemoteDataSource baseOrderRemoteDataSource;
  final NetworkServices networkServices;

  OrderRepositoryImpl(this.baseOrderRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, OrderEntity>> addOrder(
      AddOrderParameters addOrderParameters) async {
    if (await networkServices.isConnected()) {
      try {
        final response =
            await baseOrderRemoteDataSource.addOrder(addOrderParameters);
        if (response.success) {
          return Right(response.orderDetails!);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders(int start) async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseOrderRemoteDataSource.getOrders(start);
        if (response.success) {
          return Right(response.orders);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetails(String id) async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseOrderRemoteDataSource.getOrderDetails(id);
        if (response.success) {
          return Right(response.orderDetails!);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, String>> getUnRatedOrder() async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseOrderRemoteDataSource.getUnRatedOrder();
        if (response.success) {
          return Right(response.data);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> rateOrder(
      RateOrderParameters rateOrderParameters) async {
    if (await networkServices.isConnected()) {
      try {
        final response =
            await baseOrderRemoteDataSource.rateOrder(rateOrderParameters);
        if (response.success) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: response.msg));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }
}
