import 'dart:convert';

import 'package:manga_app/constant/url.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/base_service/base_service.dart';

abstract class RepositoryManga {
  Future<List<Manga>> topManga();
  Future<List<Manga>> mangaSeason();

  Future<List<Manga>> getMangaSearch(String search);
}

class MangaService extends BaseService implements RepositoryManga {
  @override
  Future<List<Manga>> getMangaSearch(String search) async {
    final res = await response(RequestType.GET,
        Url.url.mangaSearch.replaceAll('{search}', Uri.encodeFull(search)),
        headers: {'Content-Type': 'application/json'});

    final result = jsonDecode(res.body)['results'] as List;

    return result.map((e) => Manga.fromJson(e)).toList();
  }

  @override
  Future<List<Manga>> topManga() async {
    final res = await response(RequestType.GET, Url.url.topManga,
        headers: {'Content-Type': 'application/json'});
    final result = jsonDecode(res.body)['top'] as List;
    return result.take(50).map((e) => Manga.fromJson(e)).toList();
  }

  @override
  Future<List<Manga>> mangaSeason() async {
    final res = await response(RequestType.GET, Url.url.mangaSeason,
        headers: {'Content-Type': 'application/json'});

    final result = jsonDecode(res.body)['anime'] as List;

    return result.take(50).map((e) => Manga.fromJson(e)).toList();
  }
}
