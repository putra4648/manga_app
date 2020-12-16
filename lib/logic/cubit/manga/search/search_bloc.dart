import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/models.dart';
import 'package:manga_app/data/repository/repository.dart';
import 'package:manga_app/constant/constant.dart';
import 'package:manga_app/logic/logic.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<Manga> mangas;
  SearchBloc() : super(SearchInitial()) {
    mangas = <Manga>[];
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    final currentState = state;
    if (event is SearchInitEvent) {
      yield SearchLoading();
      yield SearchLoadedSuccess(mangas: mangas);
    }
    if (event is SearchEventRequested) {
      if (currentState is SearchLoadedSuccess) {
        final mangaSearch =
            await MangaRepository().getSearchManga(Type.manga, event.search);
        final currentMangas = List<Manga>.from(mangas)..addAll(mangaSearch);
        yield currentState.copyWith(mangas: currentMangas);
        print('search event');
      }
    }
  }
}
