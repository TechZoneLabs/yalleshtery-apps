import 'page_model.dart';

class PageResponse {
  final bool success;
  final List<PageModel> pageList;
  final PageModel? pageDetails;
  PageResponse({
    required this.success,
    this.pageList = const [],
    this.pageDetails,
  });
  factory PageResponse.fromJson(Map<String, dynamic> map) {
    bool containData = map.containsKey('data');
    bool dataHasList = containData ? map['data'] is List : false;
    return dataHasList
        ? PageResponse(
            success: map['success'],
            pageList: (map['data'] as List)
                .map((e) => PageModel.fromJson(e))
                .toList(),
          )
        : PageResponse(
            success: map['success'],
            pageDetails: containData ? PageModel.fromJson(map['data']) : null,
          );
  }
}
