import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/data/models/models.dart';
import 'package:manga_app/data/repository/repository.dart';
import 'package:manga_app/logic/logic.dart';

part 'season_event.dart';
part 'season_state.dart';

class SeasonBloc extends Bloc<SeasonEvent, SeasonState> {
  SeasonBloc() : super(SeasonInitial());

  @override
  Stream<SeasonState> mapEventToState(SeasonEvent event) async* {
    if (event is SeasonLoadEvent) {
      yield SeasonLoading();
      final seasonsRepo = await SeasonRepository().getMangaSeason();
      yield SeasonLoadedSuccess(seasons: seasonsRepo);
    }
  }
}
