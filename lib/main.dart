import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'app/app.dart';
import 'app/services/bloc_observer.dart';
import 'app/services/services_locator.dart';
import 'app/utils/constants_manager.dart';
import 'modules/control/presentation/controller/control_bloc.dart';
import 'modules/main/auth/presentation/controller/auth_bloc.dart';
import 'modules/main/brands/presentation/controller/brands_bloc.dart';
import 'modules/main/categories/presentation/controller/categories_bloc.dart';
import 'modules/main/home/presentation/controller/home_bloc.dart';
import 'modules/main/profile/presentation/controller/profile_bloc.dart';
import 'modules/sub/address/presentation/controller/address_bloc.dart';
import 'modules/sub/cart/presentation/controller/cart_bloc.dart';
import 'modules/sub/notification/presentation/controller/notification_bloc.dart';
import 'modules/sub/order/presentation/controller/order_bloc.dart';
import 'modules/sub/products/presentation/controller/products_bloc.dart';
import 'modules/sub/search/presentation/controller/search_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer = MyBlocObserver();
  EasyLocalization.logger.enableLevels = [LevelMessages.warning];
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await ServicesLocator.init();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(AppConstants.favouriteKey);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        AppConstants.arabic,
        AppConstants.english,
      ],
      path: AppConstants.langPath,
      fallbackLocale: AppConstants.english,
      useOnlyLangCode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ControlBloc>(create: (context) => sl()),
          BlocProvider<AuthBloc>(create: (context) => sl()),
          BlocProvider<HomeBloc>(create: (context) => sl()),
          BlocProvider<CategoriesBloc>(create: (context) => sl()),
          BlocProvider<BrandsBloc>(create: (context) => sl()),
          BlocProvider<ProductsBloc>(create: (context) => sl()),
          BlocProvider<ProfileBloc>(create: (context) => sl()),
          BlocProvider<SearchBloc>(create: (context) => sl()),
          BlocProvider<AddressBloc>(create: (context) => sl()),
          BlocProvider<NotificationBloc>(create: (context) => sl()),
          BlocProvider<CartBloc>(create: (context) => sl()),
          BlocProvider<OrderBloc>(create: (context) => sl()),
        ],
        child: Phoenix(
          child: MyApp(),
        ),
      ),
    ),
  );
}
