import 'filter_model.dart';

class FilterResponse {
  final bool success;
  final FilterModel data;

  FilterResponse({required this.success, required this.data});
  factory FilterResponse.fromJson(Map<String, dynamic> map) => FilterResponse(
        success: map['success'],
        data: FilterModel.fromJson(map['data']),
      );
}
