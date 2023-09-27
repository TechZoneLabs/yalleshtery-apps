
import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../models/trademark_response.dart';

abstract class BaseBrandsRemoteDataSource {
  Future<TrademarkResponse> getTradeMarks(DataLimitation parameter);
}

class BrandsRemoteDataSource implements BaseBrandsRemoteDataSource {
  final ApiServices apiServices;

  BrandsRemoteDataSource(this.apiServices);
  @override
  Future<TrademarkResponse> getTradeMarks(DataLimitation parameter) async {
    try {
      var map = await apiServices.get(
        file: 'trademarks.php',
        action:
            'getTrademarks&sort=title&type=ASC&start=${parameter.start}&aItemsPerPage=${parameter.limit}',
      );
      return TrademarkResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
