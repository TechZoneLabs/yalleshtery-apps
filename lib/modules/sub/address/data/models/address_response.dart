import 'address_model.dart';

class AddressResponse {
  final bool success;
  final List<AddressModel> data;

  AddressResponse({
    required this.success,
    required this.data,
  });
  factory AddressResponse.fromJson(Map<String, dynamic> map) => AddressResponse(
        success: map['success'],
        data: map.containsKey('data')
            ? (map['data'] as List)
                .map((e) => AddressModel.fromJson(e))
                .toList()
            : [],
      );
}
