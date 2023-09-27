import 'trademark_model.dart';

class TrademarkResponse {
  final bool success;
  final List<TrademarkModel> data;

  TrademarkResponse({
    required this.success,
    required this.data,
  });
  factory TrademarkResponse.fromJson(Map<String, dynamic> map) =>
      TrademarkResponse(
        success: map['success'],
        data: map.containsKey('data')
            ? (map['data'] as List)
                .map((e) => TrademarkModel.fromJson(e))
                .toList()
            : [],
      );
}
