import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/get_movies/get_movies.dart';
import 'package:path_provider/path_provider.dart';

part 'manga_state.dart';

class MangaCubit extends Cubit<MangaState> {
  MangaCubit() : super(MangaInitial());

  void getMangaData(String search) async {
    emit(MangaLoading());

    await GetManga().getManga(search).then((result) async {
      emit(MangaLoadedFromLocal(mangas: result));
    });
  }
}
