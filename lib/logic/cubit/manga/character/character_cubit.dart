import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/character.dart';
import 'package:manga_app/data/repository/get_character/get_character.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(CharacterInitial());

  void initCharacter() {
    emit(CharacterLoading());
    GetCharacter().getCharacter().then((res) {
      emit(CharacterLoaded(characters: res));
    });
  }
}
