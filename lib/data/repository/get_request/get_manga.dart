import 'dart:convert';

import '../../../constant/constant.dart';
import '../../models/models.dart';
import '../repository.dart';

class MangaRepository extends BaseService {
  Future<List<Manga>> getSearchManga(Type type, String search) async {
    final res = await response(RequestType.GET,
        Url.url.mangaSearch.replaceAll('{search}', Uri.encodeFull(search)),
        headers: {'Content-Type': 'application/json'});

    final result = jsonDecode(res.body)['results'] as List;

    return result.map((e) => Manga.fromJson(e)).toList();
  }

  Future<List<Manga>> getTopManga(Type type) async {
    final typeOfString = EnumDefinition.typeDefinition(type);
    final res = await response(
        RequestType.GET, Url.url.top.replaceAll('{type}', typeOfString),
        headers: {'Content-Type': 'application/json'});
    final result = jsonDecode(res.body)['top'] as List;
    return result.take(50).map((e) => Manga.fromJson(e)).toList();
  }
}
