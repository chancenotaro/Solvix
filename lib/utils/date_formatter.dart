import 'package:intl/intl.dart';

class SolvixDateFormatter {
  static String format(DateTime date){
    return DateFormat('MMM d, yyyy').format(date);
  }
}