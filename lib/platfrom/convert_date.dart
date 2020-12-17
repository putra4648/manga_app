import 'package:intl/intl.dart';

String convertDateJson() {
  final dateNow = DateTime.now();
  return DateFormat.EEEE().format(dateNow);
}
