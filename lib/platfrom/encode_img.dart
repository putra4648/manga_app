import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart';

Future<List<List<int>>> encodeImage() async {
  final localFile = File('test/fake.json').readAsStringSync();
  var result = <List<int>>[];
  await Future.forEach<String>(
      (jsonDecode(localFile)['results'] as List).map((e) => e['image_url']),
      (element) => get(element).then((value) => result.add(value.bodyBytes)));
  return result;
}
