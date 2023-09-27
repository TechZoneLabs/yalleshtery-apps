import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import '../../modules/control/data/datasources/remote_data_source.dart';
import '../../modules/control/data/repositories/control_repository_impl.dart';
import '../../modules/control/domain/repositories/base_control_repositories.dart';
import '../../modules/control/domain/usecases/contact_info_use_case.dart';
import '../../modules/control/presentation/controller/control_bloc.dart';
import '../../modules/main/auth/data/datasources/local_data_source.dart';
import '../../modules/main/auth/data/datasources/remote_data_source.dart';
import '../../modules/main/auth/data/repositories/auth_repository_impl.dart';
import '../../modules/main/auth/domain/repositories/base_auth_repository.dart';
import '../../modules/main/auth/domain/usecases/add_device_token_use_case.dart';
import '../../modules/main/auth/domain/usecases/change_password_use_case.dart';
import '../../modules/main/auth/domain/usecases/delete_account_use_case.dart';
import '../../modules/main/auth/domain/usecases/forget_password_use_case.dart';
import '../../modules/main/auth/domain/usecases/get_user_data_use_case.dart';
import '../../modules/main/auth/domain/usecases/log_in_use_case.dart';
import '../../modules/main/auth/domain/usecases/log_out_use_case.dart';
import '../../modules/main/auth/domain/usecases/sign_up_use_case.dart';
import '../../modules/main/auth/domain/usecases/update_profile_use_case.dart';
import '../../modules/main/auth/presentation/controller/auth_bloc.dart';
import '../../modules/main/brands/data/datasources/remote_data_source.dart';
import '../../modules/main/brands/data/repositories/brands_repository_impl.dart';
import '../../modules/main/brands/domain/repositories/base_home_repository.dart';
import '../../modules/main/brands/domain/usecases/get_tradmarks_use_case.dart';
import '../../modules/main/brands/presentation/controller/brands_bloc.dart';
import '../../modules/main/categories/data/datasources/remote_data_source.dart';
import '../../modules/main/categories/data/repositories/cats_repository_impl.dart';
import '../../modules/main/categories/domain/repositories/base_cats_repository.dart';
import '../../modules/main/categories/domain/usecases/get_categories_use_case.dart';
import '../../modules/main/categories/domain/usecases/get_mix_sub_trade_use_case.dart';
import '../../modules/main/categories/presentation/controller/categories_bloc.dart';
import '../../modules/main/home/data/datasources/remote_data_source.dart';
import '../../modules/main/home/data/repositories/home_repository_impl.dart';
import '../../modules/main/home/domain/repositories/base_home_repository.dart';
import '../../modules/main/home/domain/usecases/get_offers_use_case.dart';
import '../../modules/main/home/domain/usecases/get_slider_banners_use_case.dart';
import '../../modules/main/home/presentation/controller/home_bloc.dart';
import '../../modules/main/profile/data/datasources/remote_data_source.dart';
import '../../modules/main/profile/data/repositories/profile_repository_impl.dart';
import '../../modules/main/profile/domain/repositories/base_profile_repository.dart';
import '../../modules/main/profile/domain/usecases/get_page_details_use_case.dart';
import '../../modules/main/profile/domain/usecases/get_pages_use_case.dart';
import '../../modules/main/profile/presentation/controller/profile_bloc.dart';
import '../../modules/sub/address/data/datasources/remote_data_source.dart';
import '../../modules/sub/address/data/repositories/address_repository_impl.dart';
import '../../modules/sub/address/domain/repositories/base_address_repository.dart';
import '../../modules/sub/address/domain/usecases/add_address_use_case.dart';
import '../../modules/sub/address/domain/usecases/delete_address_use_case.dart';
import '../../modules/sub/address/domain/usecases/get_all_address_use_case.dart';
import '../../modules/sub/address/domain/usecases/get_places_use_case.dart';
import '../../modules/sub/address/presentation/controller/address_bloc.dart';
import '../../modules/sub/cart/data/datasources/remote_data_source.dart';
import '../../modules/sub/cart/data/repositories/cart_repository_impl.dart';
import '../../modules/sub/cart/domain/repositories/base_cart_repository.dart';
import '../../modules/sub/cart/domain/usecases/add_item_to_cart_use_case.dart';
import '../../modules/sub/cart/domain/usecases/check_promo_use_case.dart';
import '../../modules/sub/cart/domain/usecases/delete_cart_item_use_case.dart';
import '../../modules/sub/cart/domain/usecases/delete_promo_use_case.dart';
import '../../modules/sub/cart/domain/usecases/empty_cart_use_case.dart';
import '../../modules/sub/cart/domain/usecases/get_cart_data_use_case.dart';
import '../../modules/sub/cart/domain/usecases/update_cart_item_use_case.dart';
import '../../modules/sub/cart/presentation/controller/cart_bloc.dart';
import '../../modules/sub/notification/data/datasources/remote_data_source.dart';
import '../../modules/sub/notification/data/repositories/notification_repository_impl.dart';
import '../../modules/sub/notification/domain/repositories/base_notification_repository.dart';
import '../../modules/sub/notification/domain/usecases/delete_notification_use_case.dart';
import '../../modules/sub/notification/domain/usecases/get_notification_details_use_case.dart';
import '../../modules/sub/notification/domain/usecases/get_notifications_use_case.dart';
import '../../modules/sub/notification/domain/usecases/get_un_read_notification_num_use_case.dart';
import '../../modules/sub/notification/domain/usecases/read_notification_use_case.dart';
import '../../modules/sub/notification/presentation/controller/notification_bloc.dart';
import '../../modules/sub/order/data/datasources/remote_data_source.dart';
import '../../modules/sub/order/data/repositories/order_repository_impl.dart';
import '../../modules/sub/order/domain/repositories/base_order_repository.dart';
import '../../modules/sub/order/domain/usecases/add_order_use_case.dart';
import '../../modules/sub/order/domain/usecases/get_order_details_use_case.dart';
import '../../modules/sub/order/domain/usecases/get_orders_use_case.dart';
import '../../modules/sub/order/domain/usecases/get_un_rated_order_use_case.dart';
import '../../modules/sub/order/domain/usecases/rate_order_use_case.dart';
import '../../modules/sub/order/presentation/controller/order_bloc.dart';
import '../../modules/sub/products/data/datasources/remote_data_source.dart';
import '../../modules/sub/products/data/repositories/product_repository_impl.dart';
import '../../modules/sub/products/domain/repositories/base_product_repository.dart';
import '../../modules/sub/products/domain/usecases/add_listen_to_product_use_case.dart';
import '../../modules/sub/products/domain/usecases/get_filters_use_case.dart';
import '../../modules/sub/products/domain/usecases/get_product_details_use_case.dart';
import '../../modules/sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../modules/sub/products/presentation/controller/products_bloc.dart';
import '../../modules/sub/search/data/datasources/remote_data_source.dart';
import '../../modules/sub/search/data/repositories/product_repository_impl.dart';
import '../../modules/sub/search/domain/repositories/base_search_repository.dart';
import '../../modules/sub/search/domain/usecases/add_search_product_report_use_case.dart';
import '../../modules/sub/search/domain/usecases/get_search_data_use_case.dart';
import '../../modules/sub/search/presentation/controller/search_bloc.dart';
import '../helper/shared_helper.dart';
import 'api_services.dart';
import 'network_services.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static Future<void> init() async {
    //Local shared
    final storage = GetStorage();
    sl.registerLazySingleton<GetStorage>(() => storage);
    sl.registerLazySingleton<AppShared>(() => AppStorage(sl()));
    //Firebase messaging
    final firebaseMessaging = FirebaseMessaging.instance;
    sl.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);
    //services
    sl.registerLazySingleton<ApiServices>(() => ApiServicesImpl(sl()));
    sl.registerLazySingleton<NetworkServices>(() => InternetCheckerLookup());
    //DataSources
    sl.registerLazySingleton<BaseControlRemoteDataSource>(
      () => ControlRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
      () => AuthRemoteDataSource(sl(), sl()),
    );
    sl.registerLazySingleton<BaseAuthLocalDataSource>(
      () => AuthLocalDataSource(sl()),
    );
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
      () => HomeRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseCatsRemoteDataSource>(
      () => CatsRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseBrandsRemoteDataSource>(
      () => BrandsRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseProductRemoteDataSource>(
      () => ProductRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseSearchRemoteDataSource>(
      () => SearchRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseAddressRemoteDataSource>(
      () => AddressRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseNotificationRemoteDataSource>(
      () => NotificationRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseCartRemoteDataSource>(
      () => CartRemoteDataSource(sl()),
    );
    sl.registerLazySingleton<BaseOrderRemoteDataSource>(
      () => OrderRemoteDataSource(sl()),
    );
    //Repositories
    sl.registerLazySingleton<BaseControlRepository>(
        () => ControlRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepositoryImpl(sl(), sl(), sl()));
    sl.registerLazySingleton<BaseHomeRepository>(
        () => HomeRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseCatsRepository>(
        () => CatsRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseBrandsRepository>(
        () => BrandsRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseProductRepository>(
        () => ProductRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseProfileRepository>(
        () => ProfileRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseSearchRepository>(
        () => SearchRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseAddressRepository>(
        () => AddressRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseNotificationRepository>(
        () => NotificationRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseCartRepository>(
        () => CartRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<BaseOrderRepository>(
        () => OrderRepositoryImpl(sl(), sl()));
    //UseCases
    sl.registerLazySingleton(() => ContactInfoUseCase(sl()));
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => SignUpUseCsae(sl()));
    sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
    sl.registerLazySingleton(() => AddDeviceTokenUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
    sl.registerLazySingleton(() => DeteteAccountUseCase(sl()));
    sl.registerLazySingleton(() => GetSliderBannersUseCase(sl()));
    sl.registerLazySingleton(() => GetOffersUseCase(sl()));
    sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
    sl.registerLazySingleton(() => GetTrademarksUseCase(sl()));
    sl.registerLazySingleton(() => GetCustomProductsUseCase(sl()));
    sl.registerLazySingleton(() => GetProductDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
    sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
    sl.registerLazySingleton(() => GetPagesUseCase(sl()));
    sl.registerLazySingleton(() => GetPageDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetMixSubTradeUseCase(sl()));
    sl.registerLazySingleton(() => GetSearchDataUseCase(sl()));
    sl.registerLazySingleton(() => AddSearchProductReportsUseCase(sl()));
    sl.registerLazySingleton(() => GetFiltersUseCase(sl()));
    sl.registerLazySingleton(() => AddListenToProductUseCase(sl()));
    sl.registerLazySingleton(() => GetAllAddressesUseCase(sl()));
    sl.registerLazySingleton(() => DeleteAddressUseCase(sl()));
    sl.registerLazySingleton(() => GetPlacesUseCase(sl()));
    sl.registerLazySingleton(() => AddAddressUseCase(sl()));
    sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
    sl.registerLazySingleton(() => GetUnReadNotificationUseCase(sl()));
    sl.registerLazySingleton(() => DeleteNotificationUseCase(sl()));
    sl.registerLazySingleton(() => ReadNotificationUseCase(sl()));
    sl.registerLazySingleton(() => GetNotificationDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetCartDataUseCase(sl()));
    sl.registerLazySingleton(() => AddItemToCartUseCase(sl()));
    sl.registerLazySingleton(() => UpdateCartItemUseCase(sl()));
    sl.registerLazySingleton(() => DeleteCartItemUseCase(sl()));
    sl.registerLazySingleton(() => EmptyCartUseCase(sl()));
    sl.registerLazySingleton(() => CheckPromoUseCase(sl()));
    sl.registerLazySingleton(() => DeletePromoUseCase(sl()));
    sl.registerLazySingleton(() => AddOrderUseCase(sl()));
    sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
    sl.registerLazySingleton(() => GetOrderDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetUnRatedOrderUseCase(sl()));
    sl.registerLazySingleton(() => RateOrderUseCase(sl()));
    //blocs
    sl.registerLazySingleton(
      () => ControlBloc(
        contactInfoUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => AuthBloc(
        loginUseCase: sl(),
        signUpUseCsae: sl(),
        forgetPasswordUseCase: sl(),
        addDeviceTokenUseCase: sl(),
        logoutUseCase: sl(),
        changePasswordUseCase: sl(),
        deteteAccountUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => HomeBloc(
        getSliderBannersUseCase: sl(),
        getOffersUseCase: sl(),
        getCategoriesUseCase: sl(),
        getTrademarksUseCase: sl(),
        getCustomProductsUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => CategoriesBloc(
        getCategoriesUseCase: sl(),
        getMixSubTradeUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => BrandsBloc(
        getTrademarksUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => ProductsBloc(
        getCustomProductsUseCase: sl(),
        getProductDetailsUseCase: sl(),
        getFiltersUseCase: sl(),
        addListenToProductUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => ProfileBloc(
        getUserDataUseCase: sl(),
        updateProfileUseCase: sl(),
        getPagesUseCase: sl(),
        getPageDetailsUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => SearchBloc(
        getSearchDataUseCase: sl(),
        addSearchProductReportsUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => AddressBloc(
        getAllAddressUseCase: sl(),
        deleteAddressUseCase: sl(),
        getPlacesUseCase: sl(),
        addAddressUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => NotificationBloc(
        getNotificationsUseCase: sl(),
        getUnReadNotificationUseCase: sl(),
        deleteNotificationUseCase: sl(),
        readNotificationUseCase: sl(),
        getNotificationDetailsUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => CartBloc(
        getCartDataUseCase: sl(),
        addItemToCartUseCase: sl(),
        updateCartItemUseCase: sl(),
        deleteCartItemUseCase: sl(),
        emptyCartUseCase: sl(),
        checkPromoUseCase: sl(),
        deletePromoUseCase: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => OrderBloc(
        addOrderUseCase: sl(),
        getOrdersUseCase: sl(),
        getOrderDetailsUseCase: sl(),
        getUnRatedOrderUseCase: sl(),
        rateOrderUseCase: sl(),
      ),
    );
  }
}
