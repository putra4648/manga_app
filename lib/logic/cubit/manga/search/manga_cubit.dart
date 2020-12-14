import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/logic/logic.dart';

part 'manga_state.dart';

class MangaCubit extends Cubit<MangaState> {
  MangaCubit() : super(MangaInitial());

  // void getMangaData(String search) async {
  //   emit(MangaLoading());

  //   GetManga().getManga(search).then((result) {
  //     // File('${extAppDir.path}/result.json')
  //     //     .writeAsStringSync(jsonEncode(saveLocal));

  //     emit(MangaLoadedFromLocal(mangas: result));
  //   });
  //   // print(saveLocal.length);
  // }
  @override
  Future<void> close() {
    return super.close();
  }
}
