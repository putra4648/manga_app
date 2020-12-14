import 'dart:convert';

import 'package:manga_app/constant/url.dart';
import 'package:manga_app/data/models/manga.dart';
import 'package:manga_app/data/repository/base_service/base_service.dart';

abstract class RepositoryManga {
  Future<List<Manga>> getManga(String search);
}

class GetManga extends BaseService implements RepositoryManga {
  @override
  Future<List<Manga>> getManga(String search) async {
    final res = await response(RequestType.GET,
        Url.url.mangaSearch.replaceAll('{search}', Uri.encodeFull(search)));

    final resultBody = jsonDecode(res.body)['results'] as List;

    return resultBody.map((e) => Manga.fromJson(e)).toList();
  }
}
