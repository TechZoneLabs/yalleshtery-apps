import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String? id;
  final String cityId;
  final String countryId;
  final String title;
  final String buildingNumber;
  final String streetName;
  final String? floorNo;
  final String? apartmentNumber;
  final String specialMarque;
  final String isDefault;
  final String? dateAdded;
  final String cityName;
  final String countryName;
  final String? deliveryPrice;
  final dynamic lat;
  final dynamic lon;

  const Address({
    this.id,
    required this.cityId,
    required this.countryId,
    required this.title,
    required this.buildingNumber,
    required this.streetName,
    this.floorNo,
    this.apartmentNumber,
    required this.specialMarque,
    required this.isDefault,
    this.dateAdded,
    required this.cityName,
    required this.countryName,
    this.deliveryPrice,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [
        id,
        cityId,
        countryId,
        title,
        buildingNumber,
        streetName,
        floorNo,
        apartmentNumber,
        specialMarque,
        isDefault,
        dateAdded,
        cityName,
        countryName,
        deliveryPrice,
        lat,
        lon,
      ];
}
