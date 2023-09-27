import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../app/errors/failure.dart';

import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/mix_sub_trade.dart';
import '../../domain/usecases/get_categories_use_case.dart';
import '../../domain/usecases/get_mix_sub_trade_use_case.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetMixSubTradeUseCase getMixSubTradeUseCase;
  CategoriesBloc({
    required this.getCategoriesUseCase,
    required this.getMixSubTradeUseCase,
  }) : super(const CategoriesState()) {
    on<GetCategoriesEvent>(_getCategories);
    on<GetMixSubTradeEvent>(_getMixSubTrade);
  }
  FutureOr<void> _getCategories(
      GetCategoriesEvent event, Emitter<CategoriesState> emit) async {
    var dataLimitation = event.parameter ?? DataLimitation(start: 0, limit: 0);
    bool init = dataLimitation.start == 0;
    if (!state.isCategoryMax || init) {
      emit(state.copyWith(
        categoryStatus: init ? Status.initial : Status.loading,
        categories: init ? [] : state.categories,
      ));
      var result = await getCategoriesUseCase(dataLimitation);
      result.fold(
        (failure) => emit(
          state.copyWith(
            categoryStatus: Status.error,
            categories: init ? [] : state.categories,
          ),
        ),
        (catList) => init
            ? emit(
                state.copyWith(
                  categoryStatus: Status.loaded,
                  categories: catList,
                  isCategoryMax: catList.length < dataLimitation.limit,
                ),
              )
            : emit(
                state.copyWith(
                  categoryStatus: Status.loaded,
                  categories: List.of(state.categories)..addAll(catList),
                  isCategoryMax: catList.length < dataLimitation.limit,
                ),
              ),
      );
    }
  }

  FutureOr<void> _getMixSubTrade(
      GetMixSubTradeEvent event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(mixSubTradeStatus: Status.loading));
    Either<Failure, MixSubTrade> result =
        await getMixSubTradeUseCase(event.categoryId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          mixSubTradeStatus: Status.error,
          mixSubTrade: const MixSubTrade(
            subCategories: [],
            trademarks: [],
          ),
        ),
      ),
      (mixSubTrade) => emit(
        state.copyWith(
          mixSubTradeStatus: Status.loaded,
          mixSubTrade: mixSubTrade,
        ),
      ),
    );
  }
}
