import 'place_model.dart';

class PlaceResponse {
  final bool success;
  final List<PlaceModel> data;

  PlaceResponse({
    required this.success,
    required this.data,
  });
  factory PlaceResponse.fromJson(Map<String, dynamic> map) => PlaceResponse(
        success: map['success'],
        data: map.containsKey('data')?(map['data']as List).map((e) => PlaceModel.fromJson(e)).toList():[],
      );

}
