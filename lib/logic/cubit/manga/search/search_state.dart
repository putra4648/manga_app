part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadedSuccess extends SearchState {
  final List<Manga> mangas;

  const SearchLoadedSuccess({this.mangas});

  SearchLoadedSuccess copyWith({
    List<Manga> mangas,
  }) {
    return SearchLoadedSuccess(
      mangas: mangas ?? this.mangas,
    );
  }

  @override
  List<Object> get props => [mangas];
}
