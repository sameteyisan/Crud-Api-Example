import 'package:intl/intl.dart';

class ModelParser {
  static dayTime(DateTime? date) {
    var formatter = DateFormat("MMM dd yyyy");
    return date == null ? null : formatter.format(date);
  }
}
