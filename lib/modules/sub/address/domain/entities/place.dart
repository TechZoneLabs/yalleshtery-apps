import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final String countryId;
  final String placeType;
  final String image;
  final String deliveryPrice;
  final String plaName;
  final String countryName;

  const Place({
    required this.id,
    required this.countryId,
    required this.placeType,
    required this.image,
    required this.deliveryPrice,
    required this.plaName,
    required this.countryName,
  });

  @override
  List<Object?> get props => [
        id,
        countryId,
        placeType,
        image,
        deliveryPrice,
        plaName,
        countryName,
      ];
}
