part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitEvent extends SearchEvent {}

class SearchEventRequested extends SearchEvent {
  final String search;

  const SearchEventRequested({this.search});
}
