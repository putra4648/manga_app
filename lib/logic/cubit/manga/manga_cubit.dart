import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/get_manga/get_manga.dart';

part 'manga_state.dart';

class MangaCubit extends Cubit<MangaState> {
  MangaCubit() : super(MangaInitial());

  // TOP MANGA
  void initTopManga() {}

  // SEASONS
  void initSeasonArchive() {}

  // void getMangaData(String search) async {
  //   emit(MangaLoading());

  //   GetManga().getManga(search).then((result) {
  //     // File('${extAppDir.path}/result.json')
  //     //     .writeAsStringSync(jsonEncode(saveLocal));

  //     emit(MangaLoadedFromLocal(mangas: result));
  //   });
  //   // print(saveLocal.length);
  // }
}
