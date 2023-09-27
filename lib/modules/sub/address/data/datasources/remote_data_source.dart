import '../models/address_model.dart';

import '../../../../../app/common/model/general_response.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../models/address_response.dart';
import '../models/place_response.dart';

abstract class BaseAddressRemoteDataSource {
  Future<AddressResponse> getAllAddresses(int start);
  Future<GerenalResponse> deleteAddress(String addressId);
  Future<PlaceResponse> getPlaces(String id);
  Future<GerenalResponse> addAddress(AddressModel addressModel);
}

class AddressRemoteDataSource implements BaseAddressRemoteDataSource {
  final ApiServices apiServices;

  AddressRemoteDataSource(this.apiServices);
  @override
  Future<AddressResponse> getAllAddresses(int start) async {
    try {
      var map = await apiServices.get(
        file: 'users.php',
        action: 'getAllAddress&start=$start&aItemsPerPage=10',
      );
      return AddressResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> deleteAddress(String addressId) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'deleteAddress',
        body: {
          "address_id": addressId,
        },
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<PlaceResponse> getPlaces(String id) async {
    try {
      var map = await apiServices.get(
        file: 'places.php',
        action: 'getPlaces&parent_id=$id',
      );
      return PlaceResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> addAddress(AddressModel addressModel) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'addAddess',
        body: addressModel.toJson(),
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
