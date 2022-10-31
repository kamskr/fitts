import 'package:intl/intl.dart';

/// {@template date_formatters}
/// Collection of date formatters used by the app.
/// {@endtemplate}
class DateTimeFormatters {
  /// Example: Mon, May 8
  static String weekdayMonthDay(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }

  /// Example: Monday, May 8, 15:30
  static String weekdayMonthDayHour(DateTime date) {
    return DateFormat('EEEE, MMM d, HH:mm').format(date);
  }

  /// Example: 5/8/2021
  static String monthDayYear(DateTime date) {
    return DateFormat('M/d/yyyy').format(date);
  }

  /// Example: 5/8/2021 15:30
  static String monthDayYearTime(DateTime date) {
    return DateFormat('M/d/yyyy HH:mm').format(date);
  }

  /// Example: 22
  static String day(DateTime date) {
    return DateFormat('d').format(date);
  }

  /// Example: MAY
  static String month(DateTime date) {
    return DateFormat('MMM').format(date).toUpperCase();
  }

  /// Convert seconds to time format.
  /// Example: 1:30:00
  static String formatSeconds(
    int seconds, {
    bool showSeconds = false,
    bool showHours = true,
  }) {
    final duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    var value = twoDigitMinutes;

    if (showHours) {
      final twoDigitHours = twoDigits(duration.inHours);
      value = '$twoDigitHours:$value';
    }

    if (showSeconds) {
      value = '$value:$twoDigitSeconds';
    }

    return value;
  }
}
