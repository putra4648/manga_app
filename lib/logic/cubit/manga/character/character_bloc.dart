import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../../../data/models/models.dart';
import '../../../../data/repository/repository.dart';
import '../../../logic.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  List<Character> characters;

  CharacterBloc() : super(CharacterInitial()) {
    characters = <Character>[];
  }

  @override
  Stream<CharacterState> mapEventToState(CharacterEvent event) async* {
    final currenState = state;
    if (state is CharacterInitial) {
      yield CharacterLoading();
      await Future.delayed(const Duration(seconds: 1));
      yield CharacterLoadedSuccess(characters: characters, isEmpty: true);
    }

    if (event is CharacterRefreshRequested) {
      if (currenState is CharacterLoadedSuccess) {
        try {
          print('refresh');
          final charactersRepo = await CharacterRepository().getCharacter();
          final currentCharacters = List<Character>.from(characters)
            ..addAll(charactersRepo);
          yield currenState.copyWith(
              characters: currentCharacters, isEmpty: false);
          // yield CharacterLoadedSuccess(
          //     characters: currentCharacters, isEmpty: false);
        } catch (_) {
          yield CharacterFailure();
        }
      }
    }

    if (event is CharacterLoadEvent) {
      if (currenState is CharacterLoadedSuccess) {
        try {
          print('load');
          final charactersRepo = await CharacterRepository().getCharacter();
          final currentCharacters = List<Character>.from(characters)
            ..addAll(charactersRepo);
          yield currenState.copyWith(
              characters: currentCharacters, isEmpty: false);
        } catch (e) {
          yield CharacterFailure();
        }
      }
    }
  }
}
