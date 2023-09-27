import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/trademark.dart';
import '../../domain/usecases/get_tradmarks_use_case.dart';

part 'brands_event.dart';
part 'brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final GetTrademarksUseCase getTrademarksUseCase;
  BrandsBloc({required this.getTrademarksUseCase})
      : super(const BrandsState()) {
    on<GetBrandsEvent>(_getTrademarks);
  }

  FutureOr<void> _getTrademarks(
      GetBrandsEvent event, Emitter<BrandsState> emit) async {
    var dataLimitation = event.parameter ?? DataLimitation(start: 0, limit: 0);
    bool init = dataLimitation.start == 0;
    if (!state.isTrademarkMax || init) {
      emit(state.copyWith(
        trademarkStatus: init ? Status.initial : Status.loading,
        trademarks: init ? [] : state.trademarks,
      ));
      var result = await getTrademarksUseCase(dataLimitation);
      result.fold(
        (failure) => emit(
          state.copyWith(
            trademarkStatus: Status.error,
            trademarks: init ? [] : state.trademarks,
          ),
        ),
        (tradeList) => init
            ? emit(
                state.copyWith(
                  trademarkStatus: Status.loaded,
                  trademarks: tradeList,
                  isTrademarkMax: tradeList.length < dataLimitation.limit,
                ),
              )
            : emit(
                state.copyWith(
                  trademarkStatus: Status.loaded,
                  trademarks: List.from(state.trademarks)..addAll(tradeList),
                  isTrademarkMax: tradeList.length < dataLimitation.limit,
                ),
              ),
      );
    }
  }
}
