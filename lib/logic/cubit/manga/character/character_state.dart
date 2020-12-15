part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoadedSuccess extends CharacterState {
  final List<Character> characters;
  final bool isEmpty;

  const CharacterLoadedSuccess({this.characters, this.isEmpty});

  CharacterLoadedSuccess copyWith({
    List<Character> characters,
    bool isEmpty,
  }) {
    return CharacterLoadedSuccess(
      characters: characters ?? this.characters,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  @override
  List<Object> get props => [characters, isEmpty];
}

class CharacterFailure extends CharacterState {}
