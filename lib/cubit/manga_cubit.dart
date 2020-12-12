import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/get_movies/get_movies.dart';
import 'package:path_provider/path_provider.dart';

part 'manga_state.dart';

class MangaCubit extends Cubit<MangaState> {
  MangaCubit() : super(MangaInitial());

  void getMangaData(String search) async {
    final appDir = await getExternalStorageDirectory();
    final localDir = File(appDir.path + '/result.json');
    final picDir = File(appDir.path + '/');

    emit(MangaLoading());

    await GetManga().getManga(search).then((result) async {
      final res = result.map((e) => Manga().toJson(e)).toList();

      result.forEach((element) {
        get(element.imageUrl).then((value) {
          return File(picDir.path).writeAsBytesSync(value.bodyBytes);
        });
      });

      await localDir.exists().then(
        (value) async {
          if (value) {
            await localDir.delete(recursive: true);
          }
          await localDir
              .create(recursive: true)
              .then((value) async => value.writeAsString(jsonEncode(res)));
        },
      );
      // print(localDir.readAsStringSync());
      final localManga = (jsonDecode(localDir.readAsStringSync()) as List)
          .map((e) => Manga.fromJson(e))
          .toList();

      emit(MangaLoadedFromLocal(mangas: localManga));
    });
  }
}
