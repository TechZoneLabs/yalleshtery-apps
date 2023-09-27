import 'product_auto_complete_model.dart';

class ProductAutoCompleteResponse {
  final bool success;
  final ProductAutoCompleteDataModel? productAutoCompleteDataModel;
  ProductAutoCompleteResponse({
    required this.success,
    this.productAutoCompleteDataModel,
  });
  factory ProductAutoCompleteResponse.fromJson(Map<String, dynamic> map) =>
      ProductAutoCompleteResponse(
        success: map['success'],
        productAutoCompleteDataModel:
            map.containsKey('data') ? ProductAutoCompleteDataModel.fromJson(map) : null,
      );
}
