import '../../../../../app/common/model/general_response.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../../domain/usecases/add_search_product_report_use_case.dart';
import '../models/product_auto_complete_model_response.dart';

abstract class BaseSearchRemoteDataSource {
  Future<ProductAutoCompleteResponse> getSearchData(String searchVal);
  Future<GerenalResponse> addSearchProductReports(
      SearchReportsParameters searchReportsParameters);
}

class SearchRemoteDataSource implements BaseSearchRemoteDataSource {
  final ApiServices apiServices;

  SearchRemoteDataSource(this.apiServices);
  @override
  Future<ProductAutoCompleteResponse> getSearchData(String searchVal) async {
    try {
      var map = await apiServices.post(
        file: 'products.php',
        action: 'getProductsAutoComplete&searchKey=$searchVal',
        body: {},
      );

      return ProductAutoCompleteResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> addSearchProductReports(
      SearchReportsParameters searchReportsParameters) async {
    try {
      var map = await apiServices.post(
        file: 'products.php',
        action: 'addSearchProductReports',
        body: searchReportsParameters.toJson(),
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
