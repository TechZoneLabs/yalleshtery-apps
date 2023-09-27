part of 'address_bloc.dart';

class AddressState extends Equatable {
  final String msg;
  final Status allAddressesStatus;
  final List<Address> allAddresses;
  final bool isAllAddressesMax;
  final Status deletedAddressStatus;
  final String deletedAddressId;
  final Status coutriesStatus;
  final List<Place> coutries;
  final Status citiesStatus;
  final List<Place> cities;
  final MapStatus mapStatus;
  final LocationPermission locationStatus;
  final Set<Marker> markers;
  final LatLng? latlng;
  final Status addAddressStatus;
  final Address? addedAddress;

  const AddressState({
    this.msg = '',
    this.allAddressesStatus = Status.sleep,
    this.allAddresses = const [],
    this.isAllAddressesMax = false,
    this.deletedAddressStatus = Status.sleep,
    this.deletedAddressId = '',
    this.coutriesStatus = Status.sleep,
    this.coutries = const [],
    this.citiesStatus = Status.sleep,
    this.cities = const [],
    this.mapStatus = MapStatus.uninitialized,
    this.locationStatus = LocationPermission.unableToDetermine,
    this.markers = const {},
    this.latlng,
    this.addAddressStatus = Status.sleep,
    this.addedAddress,
  });

  AddressState copyWith({
    String? msg,
    Status? allAddressesStatus,
    List<Address>? allAddresses,
    bool? isAllAddressesMax,
    Status? deletedAddressStatus,
    String? deletedAddressId,
    Status? coutriesStatus,
    List<Place>? coutries,
    Status? citiesStatus,
    List<Place>? cities,
    MapStatus? mapStatus,
    LocationPermission? locationStatus,
    Set<Marker>? markers,
    LatLng? latlng,
    Status? addAddressStatus,
    Address? addedAddress,
  }) =>
      AddressState(
        msg: msg ?? this.msg,
        allAddressesStatus: allAddressesStatus ?? this.allAddressesStatus,
        allAddresses: allAddresses ?? this.allAddresses,
        isAllAddressesMax: isAllAddressesMax ?? this.isAllAddressesMax,
        deletedAddressStatus: deletedAddressStatus ?? this.deletedAddressStatus,
        deletedAddressId: deletedAddressId ?? this.deletedAddressId,
        coutriesStatus: coutriesStatus ?? this.coutriesStatus,
        coutries: coutries ?? this.coutries,
        citiesStatus: citiesStatus ?? this.citiesStatus,
        cities: cities ?? this.cities,
        mapStatus: mapStatus ?? this.mapStatus,
        locationStatus: locationStatus ?? this.locationStatus,
        markers: markers ?? this.markers,
        latlng: latlng ?? this.latlng,
        addAddressStatus: addAddressStatus ?? this.addAddressStatus,
        addedAddress: addAddressStatus == Status.error
            ? null
            : addedAddress ?? this.addedAddress,
      );

  @override
  List<Object?> get props => [
        msg,
        allAddressesStatus,
        allAddresses,
        isAllAddressesMax,
        deletedAddressStatus,
        deletedAddressId,
        coutriesStatus,
        coutries,
        citiesStatus,
        cities,
        mapStatus,
        locationStatus,
        markers,
        latlng,
        addAddressStatus,
        addedAddress,
      ];
}
