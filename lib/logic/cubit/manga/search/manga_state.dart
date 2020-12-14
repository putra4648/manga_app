part of 'manga_cubit.dart';

abstract class MangaState extends Equatable {
  const MangaState();

  @override
  List<Object> get props => [];
}

class MangaInitial extends MangaState {}

class MangaLoading extends MangaState {}

class MangaLoadedFromLocal extends MangaState {
  final List<Manga> mangas;

  MangaLoadedFromLocal({this.mangas});
}
