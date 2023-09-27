import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../app/errors/failure.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/place.dart';
import '../../domain/usecases/add_address_use_case.dart';
import '../../domain/usecases/delete_address_use_case.dart';
import '../../domain/usecases/get_all_address_use_case.dart';
import '../../domain/usecases/get_places_use_case.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAllAddressesUseCase getAllAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final GetPlacesUseCase getPlacesUseCase;
  final AddAddressUseCase addAddressUseCase;
  AddressBloc({
    required this.getAllAddressUseCase,
    required this.deleteAddressUseCase,
    required this.getPlacesUseCase,
    required this.addAddressUseCase,
  }) : super(const AddressState()) {
    on<GetAllAddressEvent>(_getAllAddresses);
    on<DeleteAddressEvent>(_deleteAddress);
    on<GetPlacesEvent>(_getPlaces);
    on<CheckMapPermissionEvent>(_checkMapPermission);
    on<GetCurrentPostionEvent>(_getCurrentPostion);
    on<RestLocationToCurrent>(_restLocationToCurrent);
    on<GetDataFromMap>(_getDataFromMap);
    on<ClearSavedData>(_clearSavedData);
    on<AddAddressEvent>(_addAddress);
  }
  bool hasDataSaved = false;
  String? areaFromMap;
  String? streetFromMap;
  FutureOr<void> _getAllAddresses(
      GetAllAddressEvent event, Emitter<AddressState> emit) async {
    bool init = event.start == 0;
    if (init || !state.isAllAddressesMax) {
      emit(
        state.copyWith(
          allAddressesStatus: init ? Status.initial : Status.loading,
          allAddresses: init ? [] : state.allAddresses,
          addAddressStatus: Status.sleep,
          deletedAddressStatus: Status.sleep,
        ),
      );
      Either<Failure, List<Address>> result =
          await getAllAddressUseCase(event.start);
      result.fold(
        (failure) => emit(
          state.copyWith(
            allAddressesStatus: Status.error,
            allAddresses: init ? [] : state.allAddresses,
          ),
        ),
        (addressesList) => emit(
          state.copyWith(
            allAddressesStatus: Status.loaded,
            allAddresses: List.from(state.allAddresses)..addAll(addressesList),
            isAllAddressesMax: addressesList.length < 10 ? true : false,
          ),
        ),
      );
    }
  }

  FutureOr<void> _deleteAddress(
      DeleteAddressEvent event, Emitter<AddressState> emit) async {
    emit(
      state.copyWith(
        deletedAddressStatus: Status.loading,
        deletedAddressId: '',
      ),
    );
    Either<Failure, bool> result = await deleteAddressUseCase(event.addressId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          deletedAddressStatus: Status.error,
          msg: failure.msg,
        ),
      ),
      (_) => emit(
        state.copyWith(
          deletedAddressStatus: Status.loaded,
          deletedAddressId: event.addressId,
        ),
      ),
    );
  }

  FutureOr<void> _getPlaces(
      GetPlacesEvent event, Emitter<AddressState> emit) async {
    bool isCounties = event.id == '0';
    emit(
      isCounties
          ? state.copyWith(
              coutriesStatus: Status.loading,
              allAddressesStatus: Status.sleep
            )
          : state.copyWith(
              citiesStatus: Status.loading,
            ),
    );
    Either<Failure, List<Place>> result = await getPlacesUseCase(event.id);
    result.fold(
      (failure) => emit(
        isCounties
            ? state.copyWith(
                coutriesStatus: Status.error,
                coutries: [],
              )
            : state.copyWith(
                citiesStatus: Status.error,
                cities: [],
              ),
      ),
      (placeList) => emit(
        isCounties
            ? state.copyWith(
                coutriesStatus: Status.loaded,
                coutries: placeList,
              )
            : state.copyWith(
                citiesStatus: Status.loaded,
                cities: placeList,
              ),
      ),
    );
  }

  FutureOr<void> _checkMapPermission(
      CheckMapPermissionEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(locationStatus: LocationPermission.unableToDetermine));
    LocationPermission result = await Geolocator.checkPermission();
    if (result == LocationPermission.denied ||
        result == LocationPermission.deniedForever ||
        result == LocationPermission.unableToDetermine) {
      LocationPermission locPermission = await Geolocator.requestPermission();
      emit(state.copyWith(locationStatus: locPermission));
    } else {
      emit(state.copyWith(locationStatus: result));
    }
  }

  FutureOr<void> _getCurrentPostion(
      GetCurrentPostionEvent event, Emitter<AddressState> emit) async {
    emit(event.latLng == null
        ? state.copyWith(latlng: null, mapStatus: MapStatus.initializing)
        : state.copyWith(latlng: null));
    late LatLng tempLatLng;
    if (event.latLng == null) {
      Position tempPosition = await Geolocator.getCurrentPosition();
      tempLatLng = LatLng(
        tempPosition.latitude,
        tempPosition.longitude,
      );
    }
    var marker = Marker(
      markerId: const MarkerId('SomeId'),
      position: event.latLng ?? tempLatLng,
      infoWindow: const InfoWindow(title: 'Your Location'),
    );
    emit(
      state.copyWith(
        mapStatus: MapStatus.initialized,
        latlng: event.latLng ?? tempLatLng,
        markers: Set.from({})..add(marker),
      ),
    );
  }

  FutureOr<void> _restLocationToCurrent(
      RestLocationToCurrent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(mapStatus: MapStatus.restLocation));
    var tempPosition = await Geolocator.getCurrentPosition();
    LatLng tempLatLng = LatLng(
      tempPosition.latitude,
      tempPosition.longitude,
    );
    event.mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: tempLatLng,
          zoom: 17.0,
        ),
      ),
    );
    var marker = Marker(
      markerId: const MarkerId('SomeId'),
      position: tempLatLng,
      infoWindow: const InfoWindow(title: 'Your Location'),
    );
    emit(
      state.copyWith(
        latlng: tempLatLng,
        markers: Set.from({})..add(marker),
      ),
    );
  }

  FutureOr<void> _getDataFromMap(
      GetDataFromMap event, Emitter<AddressState> emit) async {
    LatLng pos = state.markers.first.position;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    areaFromMap = placemarks.first.locality;
    streetFromMap = placemarks.first.thoroughfare;
    hasDataSaved = true;
    emit(state.copyWith(mapStatus: MapStatus.dataSelected, latlng: pos));
  }

  FutureOr<void> _clearSavedData(
      ClearSavedData event, Emitter<AddressState> emit) {
    areaFromMap = '';
    streetFromMap = '';
    hasDataSaved = false;
    emit(
      state.copyWith(
        latlng: null,
        markers: Set.from({}),
        mapStatus: MapStatus.uninitialized,
      ),
    );
  }

  FutureOr<void> _addAddress(
      AddAddressEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(
      addAddressStatus: Status.loading,
      deletedAddressStatus: Status.sleep,
    ));
    Either<Failure, bool> result = await addAddressUseCase(event.address);
    result.fold(
      (failue) => emit(
        state.copyWith(
          addAddressStatus: Status.error,
          msg: failue.msg,
        ),
      ),
      (_) => emit(
        state.copyWith(
          addAddressStatus: Status.loaded,
          addedAddress: event.address,
        ),
      ),
    );
  }
}
