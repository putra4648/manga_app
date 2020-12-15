import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/models.dart';
import 'package:manga_app/data/repository/repository.dart';
import 'package:manga_app/logic/logic.dart';

part 'season_event.dart';
part 'season_state.dart';

class SeasonBloc extends Bloc<SeasonEvent, SeasonState> {
  List<Manga> seasons;
  SeasonBloc() : super(SeasonInitial()) {
    seasons = <Manga>[];
  }

  @override
  Stream<SeasonState> mapEventToState(SeasonEvent event) async* {
    final currenState = state;
    if (event is SeasonInitEvent) {
      print('season init event');
      yield SeasonLoading();
      await Future.delayed(const Duration(seconds: 1));
      yield SeasonLoadedSuccess(isEmpty: true, seasons: seasons);
    }
    if (event is SeasonLoadEvent) {
      print('season load event');
      final seasonsRepo = await SeasonRepository().getMangaSeason();
      if (currenState is SeasonLoadedSuccess) {
        print('season loaded');
        final currenSeasons = List<Manga>.from(seasons)..addAll(seasonsRepo);
        yield currenState.copyWith(isEmpty: false, seasons: currenSeasons);
      }
    }
  }
}
