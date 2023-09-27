import '../../../brands/data/models/trademark_model.dart';
import 'category_model.dart';

class SubCategoryResponse {
  final bool success;
  final List<CategoryModel> data;
  final List<TrademarkModel> famousTrademarks;

  SubCategoryResponse({
    required this.success,
    required this.data,
    required this.famousTrademarks,
  });
  factory SubCategoryResponse.fromJson(Map<String, dynamic> map) => SubCategoryResponse(
        success: map['success'],
        data: map.containsKey('data')
            ? (map['data'] as List)
                .map((e) => CategoryModel.fromJson(e))
                .toList()
            : [],
        famousTrademarks: map.containsKey('famous_trade_marks')
            ? (map['famous_trade_marks'] as List)
                .map((e) => TrademarkModel.fromJson(e))
                .toList()
            : [],
      );
}
