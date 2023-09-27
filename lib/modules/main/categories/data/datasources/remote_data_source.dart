import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../models/category_response.dart';
import '../models/sub_category_response.dart';

abstract class BaseCatsRemoteDataSource {
  Future<CategoryResponse> getCategories(DataLimitation parameter);
  Future<SubCategoryResponse> getMixSubTrade(int categoryId);
}

class CatsRemoteDataSource implements BaseCatsRemoteDataSource {
  final ApiServices apiServices;

  CatsRemoteDataSource(this.apiServices);
  @override
  Future<CategoryResponse> getCategories(DataLimitation parameter) async {
    try {
      var map = await apiServices.get(
        file: 'services.php',
        action:
            'getCategories&parent_id=0&start=${parameter.start}&aItemsPerPage=${parameter.limit}',
      );
      return CategoryResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<SubCategoryResponse> getMixSubTrade(int categoryId) async {
     var map = await apiServices.get(
        file: 'services.php',
        action: 'getCategories&parent_id=$categoryId',
      );
      return SubCategoryResponse.fromJson(map);
  }
}
