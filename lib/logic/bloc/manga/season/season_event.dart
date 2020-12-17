part of 'season_bloc.dart';

abstract class SeasonEvent extends Equatable {
  const SeasonEvent();

  @override
  List<Object> get props => [];
}

class SeasonLoadEvent extends SeasonEvent {}
