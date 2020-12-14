part of 'season_cubit.dart';

abstract class MangaSeasonState extends Equatable {
  const MangaSeasonState();

  @override
  List<Object> get props => [];
}

class SeasonInitial extends MangaSeasonState {}

class MangaSeasonLoading extends MangaSeasonState {}

class MangaSeasonLoaded extends MangaSeasonState {
  final List<Manga> mangaSeasons;

  MangaSeasonLoaded({this.mangaSeasons});
}
