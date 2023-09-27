import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/errors/failure.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/product_auto_complete.dart';
import '../../domain/usecases/add_search_product_report_use_case.dart';
import '../../domain/usecases/get_search_data_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchDataUseCase getSearchDataUseCase;
  final AddSearchProductReportsUseCase addSearchProductReportsUseCase;
  SearchBloc({
    required this.getSearchDataUseCase,
    required this.addSearchProductReportsUseCase,
  }) : super(const SearchState()) {
    on<GetSearchData>(_getSearchData);
    on<AddSearchProductReportsEvent>(_addSearchReports);
  }

  FutureOr<void> _getSearchData(
      GetSearchData event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        searchStatus: Status.loading,
        searchVal: '',
        searchList: [],
        totalCount: -1,
      ),
    );
    Either<Failure, ProductAutoCompleteData> result =
        await getSearchDataUseCase(event.searchVal);
    result.fold(
      (failure) => emit(
        state.copyWith(
          searchStatus: Status.error,
        ),
      ),
      (searchData) => emit(
        state.copyWith(
          searchStatus: Status.loaded,
          searchVal: event.searchVal,
          searchList: searchData.data,
          totalCount: searchData.totalCount,
        ),
      ),
    );
  }

  FutureOr<void> _addSearchReports(
      AddSearchProductReportsEvent event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        searchReportStatus: Status.loading,
        totalCount: -1,
      ),
    );
    Either<Failure, bool> result =
        await addSearchProductReportsUseCase(event.searchReportsParameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          searchReportStatus: Status.error,
        ),
      ),
      (_) => emit(
        state.copyWith(
          searchReportStatus: Status.loaded,
        ),
      ),
    );
  }
}
