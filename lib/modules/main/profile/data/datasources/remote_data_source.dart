import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../models/page_response.dart';

abstract class BaseProfileRemoteDataSource {
  Future<PageResponse> getPages();
  Future<PageResponse> getPageById(String id);
}

class ProfileRemoteDataSource extends BaseProfileRemoteDataSource {
  final ApiServices apiServices;

  ProfileRemoteDataSource(this.apiServices);

  @override
  Future<PageResponse> getPages() async {
    try {
      var map = await apiServices.get(
        file: 'pages.php',
        action: 'getPages',
      );
      return PageResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<PageResponse> getPageById(String id) async {
    try {
      var map = await apiServices.get(
        file: 'pages.php',
        action: 'getPageDetails&page_id=$id',
      );
      return PageResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
