import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/address_model.dart';
import '../../domain/entities/place.dart';

import '/app/services/network_services.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/address.dart';
import '../../domain/repositories/base_address_repository.dart';
import '../datasources/remote_data_source.dart';

class AddressRepositoryImpl implements BaseAddressRepository {
  final BaseAddressRemoteDataSource baseAddressRemoteDataSource;
  final NetworkServices networkServices;

  AddressRepositoryImpl(
    this.baseAddressRemoteDataSource,
    this.networkServices,
  );

  @override
  Future<Either<Failure, List<Address>>> getAllAddresses(int start) async {
    if (await networkServices.isConnected()) {
      try {
        final addressResponse =
            await baseAddressRemoteDataSource.getAllAddresses(start);
        if (addressResponse.success) {
          return Right(addressResponse.data);
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
  Future<Either<Failure, bool>> deteleAddress(String addressId) async {
    if (await networkServices.isConnected()) {
      try {
        final response =
            await baseAddressRemoteDataSource.deleteAddress(addressId);
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

  @override
  Future<Either<Failure, List<Place>>> getPlaces(String id) async {
    if (await networkServices.isConnected()) {
      try {
        final placeResponse = await baseAddressRemoteDataSource.getPlaces(id);
        if (placeResponse.success) {
          return Right(placeResponse.data);
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
  Future<Either<Failure, bool>> addAddress(Address address) async {
    if (await networkServices.isConnected()) {
      try {
        final response = await baseAddressRemoteDataSource.addAddress(
          AddressModel(
            cityId: address.cityId,
            countryId: address.countryId,
            title: address.title,
            buildingNumber: address.buildingNumber,
            streetName: address.streetName,
            floorNo: address.floorNo,
            apartmentNumber: address.apartmentNumber,
            specialMarque: address.specialMarque,
            isDefault: address.isDefault,
            cityName: address.cityName,
            countryName: address.countryName,
            lat: address.lat,
            lon: address.lon,
          ),
        );
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
