import 'dart:convert';

import 'package:manga_app/data/models/manga.dart';
import 'package:http/http.dart' as http;

abstract class RepositoryManga {
  Future<List<Manga>> getManga(String search);
}

class GetManga implements RepositoryManga {
  @override
  Future<List<Manga>> getManga(String search) async {
    String url =
        'https://api.jikan.moe/v3/search/manga?q=${Uri.encodeFull(search)}&page=1';
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error');
    }

    final result = jsonDecode(response.body)['results'] as List;
    return result.map((e) => Manga.fromJson(e)).toList();
  }
}
