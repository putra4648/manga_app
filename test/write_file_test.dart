import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  test('cek nulis file di documentApplicationDir', () async {
    final dir = await getApplicationDocumentsDirectory();
    final file =
        File('/home/ossas/Pemrograman/Proyek_Skripsi/manga_app/test/fake.json')
            .readAsStringSync();
    print(file);
  });
}
