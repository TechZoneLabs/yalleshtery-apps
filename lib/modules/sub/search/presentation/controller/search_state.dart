part of 'search_bloc.dart';

class SearchState extends Equatable {
  final Status searchStatus;
  final String searchVal;
  final List<ProductAutoComplete> searchList;
  final int totalCount;
  final Status searchReportStatus;

  const SearchState({
    this.searchStatus = Status.sleep,
    this.searchVal = '',
    this.searchList = const [],
    this.totalCount = -1,
    this.searchReportStatus = Status.sleep,
  });
  SearchState copyWith({
    Status? searchStatus,
    String? searchVal,
    List<ProductAutoComplete>? searchList,
    int? totalCount,
    Status? searchReportStatus,
  }) =>
      SearchState(
        searchStatus: searchStatus ?? this.searchStatus,
        searchVal: searchVal ?? this.searchVal,
        searchList: searchList ?? this.searchList,
        totalCount: totalCount ?? this.totalCount,
        searchReportStatus: searchReportStatus??this.searchReportStatus,
      );
  @override
  List<Object?> get props => [
        searchStatus,
        searchVal,
        searchList,
        totalCount,
        searchReportStatus,
      ];
}
