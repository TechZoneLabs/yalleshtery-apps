import 'package:dartz/dartz.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/address.dart';
import '../entities/place.dart';

abstract class BaseAddressRepository {
  Future<Either<Failure, List<Address>>> getAllAddresses(int start);
  Future<Either<Failure, bool>> deteleAddress(String addressId);
  Future<Either<Failure, List<Place>>> getPlaces(String id);
  Future<Either<Failure, bool>> addAddress(Address address);
}
