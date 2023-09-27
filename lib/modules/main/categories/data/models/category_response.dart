import 'category_model.dart';

class CategoryResponse {
  final bool success;
  final String? error;
  final List<CategoryModel> data;

  CategoryResponse({
    required this.success,
    this.error,
    required this.data,
  });
  factory CategoryResponse.fromJson(Map<String, dynamic> map) =>
      CategoryResponse(
        success: map['success'],
        error: map.containsKey('message') ? map['message'] : null,
        data: map.containsKey('data')
            ? (map['data'] as List)
                .map((e) => CategoryModel.fromJson(e))
                .toList()
            : [],
      );
}
