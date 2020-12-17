import 'dart:async';

import 'package:equatable/equatable.dart';

import '../../../../data/models/models.dart';
import '../../../../data/repository/repository.dart';
import '../../../logic.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterInitial());

  @override
  Stream<CharacterState> mapEventToState(CharacterEvent event) async* {
    if (event is CharacterLoadEvent) {
      yield CharacterLoading();

      try {
        final charactersRepo = await CharacterRepository().getCharacter();

        yield CharacterLoadedSuccess(characters: charactersRepo);
      } catch (_) {
        yield CharacterFailure();
      }
    }
  }
}
