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
  final bool isEmpty;

  SeasonLoadedSuccess({this.seasons, this.isEmpty});

  SeasonLoadedSuccess copyWith({
    List<Manga> seasons,
    bool isEmpty,
  }) {
    return SeasonLoadedSuccess(
      seasons: seasons ?? this.seasons,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object> get props => [seasons.isEmpty];
}

class SeasonFailure extends SeasonState {}
