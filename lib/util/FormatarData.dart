import 'package:intl/intl.dart';

class FormatarData {
  static String formatarData(DateTime data) {
    String mes = data.month >= 10 ? "/${data.month}" : "/0${data.month}";
    return "${data.day}" + mes + "/${data.year}";
  }

  static DateTime convertStringToDate(String date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", 'en_US').parse(date);
  }
}
