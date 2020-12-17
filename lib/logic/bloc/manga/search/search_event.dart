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

class SearchTypeChanged extends SearchEvent {
  final Type type;

  SearchTypeChanged({this.type});

  SearchTypeChanged copyWith({
    Type type,
  }) {
    return SearchTypeChanged(
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [type];
}
