import '../../domain/entities/place.dart';

class PlaceModel extends Place {
  const PlaceModel({
    required String id,
    required String countryId,
    required String placeType,
    required String image,
    required String deliveryPrice,
    required String plaName,
    required String countryName,
  }) : super(
          id: id,
          countryId: countryId,
          placeType: placeType,
          image: image,
          deliveryPrice: deliveryPrice,
          plaName: plaName,
          countryName: countryName,
        );
  factory PlaceModel.fromJson(Map<String, dynamic> map) => PlaceModel(
        id: map['id'],
        countryId: map['country_id']??'',
        placeType: map['place_type']??'',
        image: map['image']??'',
        deliveryPrice: map['delivery_price']??'',
        plaName: map['pla_name']??'',
        countryName: map['country_name']??'',
      );
}
