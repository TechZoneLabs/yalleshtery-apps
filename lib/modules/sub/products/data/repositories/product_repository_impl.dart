import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/services/network_services.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/base_product_repository.dart';
import '../../domain/usecases/add_listen_to_product_use_case.dart';
import '../../domain/usecases/get_product_details_use_case.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';
import '../datasources/remote_data_source.dart';

class ProductRepositoryImpl implements BaseProductRepository {
  final BaseProductRemoteDataSource baseProductRemoteDataSource;
  final NetworkServices networkServices;

  ProductRepositoryImpl(this.baseProductRemoteDataSource, this.networkServices);

  @override
  Future<Either<Failure, List<Product>>> getCustomProducts(
      ProductsParmeters parmeters) async {
    if (await networkServices.isConnected()) {
      try {
        final customProductsResponse =
            await baseProductRemoteDataSource.getCustomProducts(parmeters);
        if (customProductsResponse.success) {
          return Right(customProductsResponse.data);
        } else {
          return Left(ServerFailure(msg: customProductsResponse.message!));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(
      ProductDetailsParmeters parmeters) async {
    if (await networkServices.isConnected()) {
      try {
        final productResponse =
            await baseProductRemoteDataSource.getProductDetails(parmeters);
        if (productResponse.success) {
          return Right(productResponse.data);
        } else {
          return Left(ServerFailure(msg: productResponse.message!));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, Filter>> getFilters(
      ProductsParmeters parmeters) async {
    if (await networkServices.isConnected()) {
      try {
        final filterResponse =
            await baseProductRemoteDataSource.getFilters(parmeters);
        if (filterResponse.success) {
          return Right(filterResponse.data);
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
  Future<Either<Failure, bool>> addListenToProductAvailability(
      ListenProductParameters parameters) async {
    if (await networkServices.isConnected()) {
      try {
        final result = await baseProductRemoteDataSource
            .addListenToProductAvailability(parameters);
        return Right(result);
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }
}
