import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/models.dart';
import 'package:manga_app/data/repository/get_request/get_manga.dart';
import 'package:manga_app/logic/logic.dart';
import 'package:manga_app/constant/constant.dart';

part 'top_event.dart';
part 'top_state.dart';

class TopBloc extends Bloc<TopEvent, TopState> {
  List<Manga> tops;
  TopBloc() : super(TopInitial()) {
    tops = <Manga>[];
  }

  @override
  Stream<TopState> mapEventToState(TopEvent event) async* {
    final currenState = state;

    if (event is TopInitEvent) {
      yield TopLoading();
      await Future.delayed(const Duration(seconds: 1));
      yield TopLoadedSuccess(isEmpty: true, tops: tops);
    }
    if (event is TopLoadEvent) {
      final topRepo = await MangaRepository().getTopManga(Type.manga);
      if (currenState is TopLoadedSuccess) {
        final currentTops = List<Manga>.from(tops)..addAll(topRepo);
        yield currenState.copyWith(isEmpty: false, tops: currentTops);
      }
    }
  }
}
