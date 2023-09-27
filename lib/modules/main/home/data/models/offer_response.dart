import 'offer_model.dart';

class OfferResponse {
  final bool success;
  final String? error;
  final OfferTypeModel? data;

  OfferResponse({
    required this.success,
    this.error,
    this.data,
  });
  factory OfferResponse.fromJson(Map<String, dynamic> map) => OfferResponse(
        success: map['success'],
        error: map.containsKey('message') ? map['message'] : null,
        data: map.containsKey('data')
            ? OfferTypeModel.fromJson(map['data'])
            : null,
      );
}
