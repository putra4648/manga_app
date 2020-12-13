import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  test('cek nulis file di documentApplicationDir', () async {
    final dir = await getApplicationDocumentsDirectory();
    var base64Image = <List<int>>[];
    final res = File('test/fake.json').readAsStringSync();
    await Future.forEach<String>(
            (jsonDecode(res)['results'] as List).map((e) => e['image_url']),
            (element) => get(element).then((value) => print(value.bodyBytes)))
        .whenComplete(() => print("Length : " + base64Image.length.toString()));
    // base64Image.add(base64.encode(value));
    // print(base64Image.length);
  });
}
