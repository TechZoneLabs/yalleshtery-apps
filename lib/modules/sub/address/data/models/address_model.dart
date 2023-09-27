import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    String? id,
    required String cityId,
    required String countryId,
    required String title,
    required String buildingNumber,
    required String streetName,
    String? floorNo,
    String? apartmentNumber,
    required String specialMarque,
    required String isDefault,
    String? dateAdded,
    required String cityName,
    required String countryName,
    String? deliveryPrice,
    required lat,
    required lon,
  }) : super(
          id: id,
          cityId: cityId,
          countryId: countryId,
          title: title,
          buildingNumber: buildingNumber,
          streetName: streetName,
          floorNo: floorNo,
          apartmentNumber: apartmentNumber,
          specialMarque: specialMarque,
          isDefault: isDefault,
          dateAdded: dateAdded,
          cityName: cityName,
          countryName: countryName,
          deliveryPrice: deliveryPrice,
          lat: lat,
          lon: lon,
        );
  factory AddressModel.fromJson(Map<String, dynamic> map) => AddressModel(
        isDefault: map['is_default'],
        title: map['title'],
        buildingNumber: map['building_number'],
        streetName: map['street_name'],
        //floorNo: map['floor_no'],
        //apartmentNumber: map['apartment_number'],
        specialMarque: map['special_marque'],
        countryId: map['country_id'],
        countryName: map['country_name'],
        id: map['id'],
        cityId: map['city_id'],
        cityName: map['city_name'],
        dateAdded: map['date_added'],
        deliveryPrice: map['delivery_price']??'0.0',
        lat: map['lat'],
        lon: map['lon'],
      );
  Map<String, dynamic> toJson() => {
        'is_default': isDefault,
        'title': title,
        'building_number': buildingNumber,
        'street_name': streetName,
        //'floor_no': floorNo,
        //'apartment_number': apartmentNumber,
        'special_marque': specialMarque,
        'country_id': countryId,
        'country_name': countryName,
        'city_id': cityId,
        'city_name': cityName,
        'lat': lat,
        'lon': lon,
      };
}
