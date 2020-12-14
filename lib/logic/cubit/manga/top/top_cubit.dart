import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/repository.dart';

part 'top_state.dart';

class TopMangaCubit extends Cubit<TopMangaState> {
  TopMangaCubit() : super(TopInitial());

  // TOP MANGA
  void initTopManga() {
    emit(TopMangaLoading());
    MangaService().topManga().then((result) {
      emit(TopMangaLoaded(topMangas: result));
    }).catchError((_) {
      emit(TopMangaFailure());
    });
  }
}
