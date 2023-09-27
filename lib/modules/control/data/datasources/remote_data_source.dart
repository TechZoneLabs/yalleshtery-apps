import '../../../../app/errors/exception.dart';
import '../../../../app/services/api_services.dart';
import '../models/contact_info_response.dart';

abstract class BaseControlRemoteDataSource {
  Future<ContactInfoResponse> getContactInfo();
}

class ControlRemoteDataSource implements BaseControlRemoteDataSource {
  final ApiServices apiServices;

  ControlRemoteDataSource(this.apiServices);
  @override
  Future<ContactInfoResponse> getContactInfo() async {
    try {
      var map = await apiServices.get(
        file: 'settings.php',
        action: 'getAllContanctInfo',
      );
      return ContactInfoResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
