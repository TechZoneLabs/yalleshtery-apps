import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../sub/products/domain/entities/product.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../../brands/domain/entities/trademark.dart';
import '../../../brands/domain/usecases/get_tradmarks_use_case.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/domain/usecases/get_categories_use_case.dart';
import '../../domain/entities/offer.dart';
import '../../domain/entities/slider_banner.dart';

import '../../domain/usecases/get_offers_use_case.dart';
import '../../domain/usecases/get_slider_banners_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetSliderBannersUseCase getSliderBannersUseCase;
  final GetOffersUseCase getOffersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetTrademarksUseCase getTrademarksUseCase;
  final GetCustomProductsUseCase getCustomProductsUseCase;
  HomeBloc(
      {required this.getSliderBannersUseCase,
      required this.getOffersUseCase,
      required this.getCategoriesUseCase,
      required this.getTrademarksUseCase,
      required this.getCustomProductsUseCase})
      : super(const HomeState()) {
    on<GetSliderBannersEvent>(_getSliderBanners);
    on<GetOffersEvent>(_getOffers);
    on<GetHomeCategoriesEvent>(_getCategories);
    on<GetTrademarksEvent>(_getTrademarks);
    on<GetLastestProductsEvent>(_getLastestProducts);
    on<GetBestSellerProductsEvent>(_getBestSellerProducts);
    on<UpdateHomeProducts>(_updateHomeProducts);
  }

  FutureOr<void> _getSliderBanners(
      GetSliderBannersEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      sliderBannerStatus: Status.initial,
    ));
    var result = await getSliderBannersUseCase(const NoParameters());
    result.fold(
      (failure) => emit(
        state.copyWith(
          sliderBannerStatus: Status.error,
          sliderBannersList: [],
        ),
      ),
      (sliderList) => emit(
        state.copyWith(
          sliderBannersList: sliderList,
          sliderBannerStatus: Status.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getOffers(
      GetOffersEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      offerTypeStatus: Status.initial,
      offerType: const OfferType(
        inSlider: [],
        inCategories: [],
        inLastProducts: [],
        inTrademarks: [],
      ),
    ));
    var result = await getOffersUseCase(const NoParameters());
    result.fold(
      (failure) => emit(
        state.copyWith(
          offerTypeStatus: Status.error,
        ),
      ),
      (offerType) => emit(
        state.copyWith(
          offerTypeStatus: Status.loaded,
          offerType: offerType,
        ),
      ),
    );
  }

  FutureOr<void> _getCategories(
      GetHomeCategoriesEvent event, Emitter<HomeState> emit) async {
    var dataLimitation = event.parameter ?? DataLimitation(start: 0, limit: 10);
    bool init = dataLimitation.start == 0;
    if (!state.isCategoryMax || init) {
      emit(state.copyWith(
        categoryStatus: init ? Status.initial : Status.loading,
      ));
      var result = await getCategoriesUseCase(dataLimitation);
      result.fold(
        (failure) => emit(
          state.copyWith(
            categoryStatus: Status.error,
            categories: init ? [] : state.categories,
          ),
        ),
        (catList) => emit(
          state.copyWith(
            categoryStatus: Status.loaded,
            categories: catList,
          ),
        ),
      );
    }
  }

  FutureOr<void> _getTrademarks(
      GetTrademarksEvent event, Emitter<HomeState> emit) async {
    var dataLimitation = event.parameter ?? DataLimitation(start: 0, limit: 10);
    bool init = dataLimitation.start == 0;
    if (!state.isTrademarkMax || init) {
      emit(state.copyWith(
        trademarkStatus: init ? Status.initial : Status.loading,
      ));
      var result = await getTrademarksUseCase(dataLimitation);
      result.fold(
        (failure) => emit(
          state.copyWith(
            trademarkStatus: Status.error,
            trademarks: [],
          ),
        ),
        (tradeList) => emit(
          state.copyWith(
            trademarkStatus: Status.loaded,
            trademarks: tradeList,
          ),
        ),
      );
    }
  }

  FutureOr<void> _getLastestProducts(
      GetLastestProductsEvent event, Emitter<HomeState> emit) async {
    if (!state.isLastestProdMax || event.start == 0) {
      emit(state.copyWith(
        lastestProdStatus: event.start == 0 ? Status.initial : Status.loading,
      ));
      var result = await getCustomProductsUseCase(
        ProductsParmeters(start: event.start),
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            lastestProdStatus: Status.error,
            lastestProds: [],
          ),
        ),
        (lastestProds) => emit(
          state.copyWith(
            lastestProdStatus: Status.loaded,
            lastestProds: lastestProds,
          ),
        ),
      );
    }
  }

  FutureOr<void> _getBestSellerProducts(
      GetBestSellerProductsEvent event, Emitter<HomeState> emit) async {
    if (!state.isBestSellerProdMax || event.start == 0) {
      emit(state.copyWith(
        bestSellerProdStatus:
            event.start == 0 ? Status.initial : Status.loading,
      ));
      var result = await getCustomProductsUseCase(
        ProductsParmeters(
          start: event.start,
          mode: 'best_seller',
        ),
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            bestSellerProdStatus: Status.error,
            bestSellerProds: [],
          ),
        ),
        (bestProds) => emit(
          state.copyWith(
            bestSellerProds: bestProds,
            bestSellerProdStatus: Status.loaded,
          ),
        ),
      );
    }
  }

  FutureOr<void> _updateHomeProducts(
      UpdateHomeProducts event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        lastestProdStatus: Status.updating,
        bestSellerProdStatus: Status.updating,
      ),
    );
    emit(
      state.copyWith(
        lastestProdStatus: Status.updated,
        lastestProds: state.lastestProds
            .map((e) => event.forceRest
                ? e.copyWith(quantityInCart: '0')
                : e.id == event.productId
                    ? e.copyWith(quantityInCart: event.quantity)
                    : e)
            .toList(),
        bestSellerProdStatus: Status.updated,
        bestSellerProds: state.bestSellerProds
            .map((e) => event.forceRest
                ? e.copyWith(quantityInCart: '0')
                : e.id == event.productId
                    ? e.copyWith(quantityInCart: event.quantity)
                    : e)
            .toList(),
      ),
    );
  }
}
