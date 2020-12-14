import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/repository.dart';

part 'season_state.dart';

class SeasonMangaCubit extends Cubit<MangaSeasonState> {
  SeasonMangaCubit() : super(SeasonInitial());

  void initSeason() {
    emit(MangaSeasonLoading());
    MangaService().mangaSeason().then((res) {
      emit(MangaSeasonLoaded(mangaSeasons: res));
    });
  }
}
