part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetSearchData extends SearchEvent {
  final String searchVal;
  const GetSearchData({required this.searchVal});
}

class AddSearchProductReportsEvent extends SearchEvent {
  final SearchReportsParameters searchReportsParameters;
  const AddSearchProductReportsEvent({required this.searchReportsParameters});
}
