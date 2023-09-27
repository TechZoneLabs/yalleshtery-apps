part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class GetAllAddressEvent extends AddressEvent {
  final int start;
  const GetAllAddressEvent({this.start = 0});
}

class DeleteAddressEvent extends AddressEvent {
  final String addressId;
  const DeleteAddressEvent({required this.addressId});
}

class GetPlacesEvent extends AddressEvent {
  final String id;
  const GetPlacesEvent({this.id = '0'});
}

class CheckMapPermissionEvent extends AddressEvent {}

class GetCurrentPostionEvent extends AddressEvent {
  final LatLng? latLng;
  const GetCurrentPostionEvent({this.latLng});
}

class RestLocationToCurrent extends AddressEvent {
  final GoogleMapController mapController;
  const RestLocationToCurrent({required this.mapController});
}

class GetDataFromMap extends AddressEvent {}

class ClearSavedData extends AddressEvent {}

class AddAddressEvent extends AddressEvent {
  final Address address;
  const AddAddressEvent({required this.address});
}
