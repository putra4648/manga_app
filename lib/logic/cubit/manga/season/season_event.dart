part of 'season_bloc.dart';

abstract class SeasonEvent extends Equatable {
  const SeasonEvent();

  @override
  List<Object> get props => [];
}

class SeasonInitEvent extends SeasonEvent {}

class SeasonLoadEvent extends SeasonEvent {}

class SeasonChangedEvent extends SeasonEvent {}
