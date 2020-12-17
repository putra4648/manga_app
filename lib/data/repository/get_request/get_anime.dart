import 'dart:convert';

import 'package:manga_app/constant/url/url.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/platfrom/convert_date.dart';

import '../repository.dart';

class AnimeRepository extends BaseService {
  Future<List<Manga>> getAnimeSchedule() async {
    final res = await response(
        RequestType.GET,
        Url.url.animeSchedule
            .replaceAll('{day}', convertDateJson().toLowerCase()));
    final result =
        jsonDecode(res.body)[convertDateJson().toLowerCase()] as List;

    return result.map((e) => Manga.fromJson(e)).toList();
  }
}
