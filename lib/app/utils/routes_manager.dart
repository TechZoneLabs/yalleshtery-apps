import 'package:flutter/material.dart';

import '../../modules/control/presentation/pages/control_page.dart';
import '../../modules/control/presentation/pages/toggle_pages.dart';
import '../../modules/control/presentation/widgets/custom_app_bar.dart';
import '../../modules/main/auth/presentation/pages/auth_page.dart';
import '../../modules/main/auth/presentation/pages/forget_password_page.dart';
import '../../modules/main/brands/presentation/pages/trademarks_page.dart';
import '../../modules/main/categories/presentation/pages/categories_page.dart';
import '../../modules/main/categories/presentation/pages/sub_categories_page.dart';
import '../../modules/main/profile/presentation/pages/edit_profile_page.dart';
import '../../modules/main/profile/presentation/pages/favourites_page.dart';
import '../../modules/main/profile/presentation/pages/orders_page.dart';
import '../../modules/main/profile/presentation/pages/shipping_addresses_page.dart';
import '../../modules/main/profile/presentation/pages/wallet_page.dart';
import '../../modules/sub/address/presentation/pages/add_address_page.dart';
import '../../modules/sub/address/presentation/pages/address_map_page.dart';
import '../../modules/sub/cart/presentation/pages/cart_page.dart';
import '../../modules/sub/notification/presentation/pages/notification_details_page.dart';
import '../../modules/sub/notification/presentation/pages/notification_page.dart';
import '../../modules/sub/order/presentation/pages/order_details_page.dart';
import '../../modules/sub/products/presentation/pages/offer_products_page.dart';
import '../../modules/sub/products/presentation/pages/product_details_page.dart';
import '../../modules/sub/products/presentation/pages/temp_products_page.dart';
import '../../modules/sub/search/presentation/pages/barcode_page.dart';
import '../../modules/sub/search/presentation/pages/search_page.dart';
import '../helper/shared_helper.dart';
import '../services/services_locator.dart';
import 'color_manager.dart';
import 'constants_manager.dart';

class Routes {
  static const String authRoute = "/auth";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String togglePagesRoute = '/togglePages';
  static const String searchRoute = '/search';
  static const String barCodeRoute = '/barCode';
  static const String categriesRoute = '/categries';
  static const String trademarksRoute = '/trademarks';
  static const String tempProductsRoute = '/tempProducts';
  static const String productDetailsRoute = '/productDetails';
  static const String subCategriesRoute = '/subCategries';
  static const String editProfileRoute = '/editProfile';
  static const String langRoute = '/language';
  static const String favouritesRoute = '/favourites';
  static const String addressesRoute = '/addresses';
  static const String addAddressRoute = '/addAddress';
  static const String addressMapRoute = '/addressMap';
  static const String notificationRoute = '/notification';
  static const String notificationDetailsRoute = '/notificationDetails';
  static const String cartRoute = '/cart';
  static const String ordersRoute = '/orders';
  static const String ordersDetailsRoute = '/ordersDetails';
  static const String offerProductsRoute = '/offerProducts';
  static const String walletRoute = '/walletRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    bool isGuest = sl<AppShared>().getVal(AppConstants.userTokenKey) == '0';
    switch (settings.name) {
      case Routes.authRoute:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());
      case Routes.togglePagesRoute:
        return MaterialPageRoute(builder: (_) => const TogglePages());
      case Routes.searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case Routes.barCodeRoute:
        return MaterialPageRoute(builder: (_) => const BarcodePage());
      case Routes.categriesRoute:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: ColorManager.background,
            appBar: CustomAppBar(
              context: context,
              hasBackButton: true,
              hasCartIcon: !isGuest,
            ),
            body: const CategoriesPage(),
          ),
        );
      case Routes.trademarksRoute:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: ColorManager.background,
            appBar: CustomAppBar(
              context: context,
              hasBackButton: true,
              hasCartIcon: !isGuest,
            ),
            body: const TrademarksPage(),
          ),
        );
      case Routes.tempProductsRoute:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TempProductsPage(
            title: map['title'],
            productsParmeters: map['productsParmeters'],
          ),
        );
      case Routes.productDetailsRoute:
        return MaterialPageRoute(builder: (_) => const ProductDetailsPage());
      case Routes.subCategriesRoute:
        return MaterialPageRoute(builder: (_) => const SubCategoriesPage());
      case Routes.editProfileRoute:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case Routes.favouritesRoute:
        return MaterialPageRoute(builder: (_) => const FavouritesPage());
      case Routes.addressesRoute:
        return MaterialPageRoute(builder: (_) => const ShippingAddressesPage());
      case Routes.walletRoute:
        return MaterialPageRoute(builder: (_) => const WalletPage());
      case Routes.addAddressRoute:
        return MaterialPageRoute(builder: (_) => const AddAddressPage());
      case Routes.addressMapRoute:
        return MaterialPageRoute(builder: (_) => const AddressMapPage());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case Routes.notificationDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => const NotificationDetailsPage(),
        );
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case Routes.ordersRoute:
        return MaterialPageRoute(builder: (_) => const OrdersPage());
      case Routes.ordersDetailsRoute:
        return MaterialPageRoute(builder: (_) => const OrderDetailsPage());
      case Routes.offerProductsRoute:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OfferProductsPage(
            offerData: map['offerData'],
            productsParmeters: map['productsParmeters'],
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const ControlPage());
    }
  }
}
