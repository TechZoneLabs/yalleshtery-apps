import '../../../../../app/common/model/general_response.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../../domain/usecases/add_order_use_case.dart';
import '../../domain/usecases/rate_order_use_case.dart';
import '../models/order_response.dart';
import '../models/un_rated_order_response.dart';

abstract class BaseOrderRemoteDataSource {
  Future<OrderResponse> addOrder(AddOrderParameters addOrderParameters);
  Future<OrderResponse> getOrders(int start);
  Future<OrderResponse> getOrderDetails(String id);
  Future<UnRatedOrderResponse> getUnRatedOrder();
  Future<GerenalResponse> rateOrder(RateOrderParameters rateOrderParameters);
}

class OrderRemoteDataSource extends BaseOrderRemoteDataSource {
  final ApiServices apiServices;

  OrderRemoteDataSource(this.apiServices);

  @override
  Future<OrderResponse> addOrder(AddOrderParameters addOrderParameters) async {
    try {
      var map = await apiServices.post(
        file: 'invoices.php',
        action: 'addInvoice',
        body: addOrderParameters.toJson(),
      );
      return OrderResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<OrderResponse> getOrders(int start) async {
    try {
      var map = await apiServices.get(
        file: 'invoices.php',
        action: 'getInvoices&start=$start&aItemsPerPage=10',
      );
      return OrderResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<OrderResponse> getOrderDetails(String id) async {
    try {
      var map = await apiServices.get(
        file: 'invoices.php',
        action: 'getOneInvoice&invoice_id=$id',
      );
      return OrderResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<UnRatedOrderResponse> getUnRatedOrder() async {
    try {
      var map = await apiServices.get(
        file: 'invoices.php',
        action: 'getInvoiceUnRate',
      );
      return UnRatedOrderResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> rateOrder(
      RateOrderParameters rateOrderParameters) async {
    try {
      var map = await apiServices.post(
        file: 'invoices.php',
        action: 'addRateInInvoice',
        body: rateOrderParameters.toJson(),
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
