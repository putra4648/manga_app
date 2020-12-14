part of 'search_cubit.dart';

abstract class SearchMangaState extends Equatable {
  const SearchMangaState();

  @override
  List<Object> get props => [];
}

class MangaInitial extends SearchMangaState {}

class MangaLoading extends SearchMangaState {}

class MangaLoadedFromLocal extends SearchMangaState {
  final List<Manga> mangas;

  MangaLoadedFromLocal({this.mangas});
}
