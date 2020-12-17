import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('return day of today', () {
    // String date = convertDateJson();
    String date = DateFormat.EEEE().format(DateTime.now());

    expect(date.toLowerCase(), 'thursday');
  });
}
