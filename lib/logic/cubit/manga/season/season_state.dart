part of 'season_cubit.dart';

abstract class SeasonMangaState extends Equatable {
  const SeasonMangaState();

  @override
  List<Object> get props => [];
}

class SeasonInitial extends SeasonMangaState {}

class SeasonMangaLoading extends SeasonMangaState {}

class SeasonMangaLoaded extends SeasonMangaState {
  final List<Manga> mangaSeasons;

  SeasonMangaLoaded({this.mangaSeasons});
}

class SeasonMangaFailure extends SeasonMangaState {}
