import 'package:intl/intl.dart';

abstract class DateService {
  /// Method to convert ISO 8601 date-time string to a specific format
  static String? formatDate(String? isoDate, {String? format = 'dd/MM/yyyy'}) {
    if (isoDate == null || format == null) {
      return null;
    }
    try {
      DateTime dateTime = DateTime.parse(isoDate);
      return DateFormat(format).format(dateTime);
    } catch (e) {
      return 'Invalid date format';
    }
  }

  /// Method to get the current date in a specific format
  static String getCurrentDate({String format = 'dd/MM/yyyy'}) {
    DateTime now = DateTime.now();
    return DateFormat(format).format(now);
  }

  /// Method to convert a DateTime object to a specific format
  static String formatDateTime(DateTime? dateTime,
      {String? format = 'dd/MM/yyyy'}) {
    if (dateTime == null || format == null) {
      return 'Invalid date';
    }
    return DateFormat(format).format(dateTime);
  }

  static String formateDateTimeBeforeSendToServer(
      {required DateTime dateTime}) {
    String format = (dateTime.hour != 0 || dateTime.minute != 0)
        ? 'yyyy-MM-dd HH:mm'
        : 'yyyy-MM-dd';
    return formatDateTime(dateTime, format: format);
  }

  /// Method to parse a formatted date string back to DateTime
  static DateTime? parseDate(String? formattedDate,
      {String? format = 'dd/MM/yyyy'}) {
    if (formattedDate == null || format == null) {
      return null;
    }
    try {
      return DateFormat(format).parse(formattedDate);
    } catch (e) {
      return null;
    }
  }

  static String? getWeekdayName(String? dateString) {
    try {
      if (dateString == null || dateString.isEmpty) return null;
      // Parse the string date to a DateTime object
      DateTime date = DateTime.parse(dateString);

      // Format the date to get the weekday name (e.g., Mon, Tue)
      String weekday = DateFormat('EEE').format(date);

      return weekday;
    } catch (e) {
      return null;
    }
  }

  static int? getDaysInMonth(String? dateString) {
    try {
      if (dateString == null || dateString.isEmpty) return null;
      // Parse the string date to a DateTime object
      DateTime date = DateTime.parse(dateString);
      return date.day;
    } catch (ex) {
      return null;
    }
  }
}
