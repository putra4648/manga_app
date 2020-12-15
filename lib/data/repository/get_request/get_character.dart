import 'dart:convert';

import '../../../constant/constant.dart';
import '../../models/models.dart';
import '../base_service/base_service.dart';

class CharacterRepository extends BaseService {
  Future<List<Character>> getCharacter() async {
    final res = await response(RequestType.GET, Url.url.character);

    final result = jsonDecode(res.body)['top'] as List;
    // print(result);
    return result.map((e) => Character.fromJson(e)).toList();
  }
}
