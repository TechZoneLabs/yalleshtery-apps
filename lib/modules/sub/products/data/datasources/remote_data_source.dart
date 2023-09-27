import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../../domain/usecases/add_listen_to_product_use_case.dart';
import '../../domain/usecases/get_product_details_use_case.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';
import '../models/filter_response.dart';
import '../models/product_response.dart';

abstract class BaseProductRemoteDataSource {
  Future<ProductsResponse> getCustomProducts(ProductsParmeters parmeters);
  Future<ProductResponse> getProductDetails(ProductDetailsParmeters parmeters);
  Future<FilterResponse> getFilters(ProductsParmeters parmeters);
  Future<bool> addListenToProductAvailability(
      ListenProductParameters parameters);
}

class ProductRemoteDataSource implements BaseProductRemoteDataSource {
  final ApiServices apiServices;

  ProductRemoteDataSource(this.apiServices);

  @override
  Future<ProductsResponse> getCustomProducts(
      ProductsParmeters parmeters) async {
    try {
      String action = 'getProducts&start=${parmeters.start}&aItemsPerPage=10';
      if (parmeters.searchTrademarkId != null &&
          parmeters.searchTrademarkId != '') {
        action += '&searchTrademark_id=${parmeters.searchTrademarkId}';
      }
      if (parmeters.searchCategoryId != null &&
          parmeters.searchCategoryId != '') {
        action += '&searchCategoryId=${parmeters.searchCategoryId}';
      }
      if (parmeters.mode != null && parmeters.mode != '') {
        action += '&mode=${parmeters.mode}';
      }
      if (parmeters.inStock != null && parmeters.inStock != '') {
        action += '&searchStatusStock=${parmeters.inStock}';
      }
      if (parmeters.minPrice != null && parmeters.minPrice != '') {
        action += '&searchPriceFrom=${parmeters.minPrice}';
      }
      if (parmeters.maxPrice != null && parmeters.maxPrice != '') {
        action += '&searchPriceTo=${parmeters.maxPrice}';
      }
      if (parmeters.offerId != null && parmeters.offerId != '') {
        action += '&offer_id=${parmeters.offerId}';
      }
      if (parmeters.filterType != null && parmeters.filterType != '') {
        action += '&filter_type=${parmeters.filterType}';
      }
      if (parmeters.sort != null && parmeters.sort != '') {
        action += '&sort=${parmeters.sort}';
      }
      if (parmeters.type != null && parmeters.type != '') {
        action += '&type=${parmeters.type}';
      }
      if (parmeters.searchKey != null && parmeters.searchKey != '') {
        action += '&searchKey=${parmeters.searchKey}';
      }
      var map = await apiServices.post(
        file: 'products.php',
        action: action,
        body: {
          "prod_ids": parmeters.ids,
          "form_shape": parmeters.formShape,
          "searchMultiPrices": parmeters.searchMultiPrices,
        },
      );
      return ProductsResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<ProductResponse> getProductDetails(
      ProductDetailsParmeters parmeters) async {
    try {
      String action = 'getProductDetails';
      if (parmeters.productId != null) {
        action += '&product_id=${parmeters.productId}';
      }
      if (parmeters.productBarcode != null) {
        action += '&product_barcode=${parmeters.productBarcode}';
      }
      var map = await apiServices.get(
        file: 'products.php',
        action: action,
      );
      return ProductResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<FilterResponse> getFilters(ProductsParmeters parmeters) async {
    try {
      String action = 'getFiltersOfProducts';
      if (parmeters.searchTrademarkId != null&&
          parmeters.searchTrademarkId != '') {
        action += '&searchTrademark_id=${parmeters.searchTrademarkId}';
      }
      if (parmeters.searchCategoryId != null&&
          parmeters.searchCategoryId != '') {
        action += '&searchCategoryId=${parmeters.searchCategoryId}';
      }
      var map = await apiServices.get(
        file: 'products.php',
        action: action,
      );
      return FilterResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<bool> addListenToProductAvailability(
      ListenProductParameters parameters) async {
    try {
      var map = await apiServices.post(
        file: 'products.php',
        action: 'listenToProductAvailability',
        body: {
          "product_id": parameters.productId,
          "note": parameters.note,
        },
      );
      return map['success'];
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
