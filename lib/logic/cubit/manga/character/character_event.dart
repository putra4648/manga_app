part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class CharacterInitEvent extends CharacterEvent {}

class CharacterRefreshRequested extends CharacterEvent {}

class CharacterSubtypeRequested extends CharacterEvent {}

class CharacterLoadEvent extends CharacterEvent {}

class CharacterChangedTypeEvent extends CharacterEvent {}
