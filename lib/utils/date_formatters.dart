import 'package:intl/intl.dart';

/// {@template date_formatters}
/// Collection of date formatters used by the app.
/// {@endtemplate}
class DateFormatters {
  /// Example: Mon, May 8
  static String weekdayMonthDay(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }

  /// Example: 22
  static String day(DateTime date) {
    return DateFormat('d').format(date);
  }

  /// Example: MAY
  static String month(DateTime date) {
    return DateFormat('MMM').format(date).toUpperCase();
  }
}
