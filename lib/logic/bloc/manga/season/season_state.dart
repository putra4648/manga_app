part of 'season_bloc.dart';

abstract class SeasonState extends Equatable {
  const SeasonState();

  @override
  List<Object> get props => [];
}

class SeasonInitial extends SeasonState {}

class SeasonLoading extends SeasonState {}

class SeasonLoadedSuccess extends SeasonState {
  final List<Manga> seasons;

  SeasonLoadedSuccess({this.seasons});

  SeasonLoadedSuccess copyWith({
    List<Manga> seasons,
  }) {
    return SeasonLoadedSuccess(
      seasons: seasons ?? this.seasons,
    );
  }

  @override
  List<Object> get props => [seasons.isEmpty];
}

class SeasonFailure extends SeasonState {}
