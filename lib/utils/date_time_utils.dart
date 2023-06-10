import 'package:intl/intl.dart';

class DateTimeUtils {
  
  static String getFormatedDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }
  
  static String getFormateDateInString(DateTime dateTime) {
    return DateFormat.MMMEd().format(dateTime);
  }
}