import 'dart:convert';

import 'package:manga_app/constant/url.dart';
import 'package:manga_app/data/models/character.dart';
import 'package:manga_app/data/repository/base_service/base_service.dart';

class GetCharacter extends BaseService {
  Future<List<Character>> getCharacter() async {
    final res = await response(RequestType.GET, Url.url.character);

    final result = jsonDecode(res.body)['top'] as List;
    return result.map((e) => Character.fromJson(e)).toList();
  }
}
