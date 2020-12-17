import 'package:flutter_test/flutter_test.dart';

import 'package:manga_app/data/models/models.dart';
import 'package:manga_app/data/repository/get_request/get_anime.dart';
import 'package:mockito/mockito.dart';

void main() {
  test('should return list manga in future', () async {
    when(AnimeRepository().getAnimeSchedule())
        .thenAnswer((_) async => <Manga>[]);
    expect(await AnimeRepository().getAnimeSchedule(), <Manga>[]);
  });
}
