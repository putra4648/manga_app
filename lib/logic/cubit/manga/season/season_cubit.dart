import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/repository.dart';

part 'season_state.dart';

class SeasonMangaCubit extends Cubit<SeasonMangaState> {
  SeasonMangaCubit() : super(SeasonInitial());

  void initSeason() {
    emit(SeasonMangaLoading());
    MangaService().mangaSeason().then((res) {
      emit(SeasonMangaLoaded(mangaSeasons: res));
    }).catchError((_) {
      emit(SeasonMangaFailure());
    });
  }
}
