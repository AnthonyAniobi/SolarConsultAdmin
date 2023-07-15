import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get minuteId => DateFormat("yyy:MM:dd:hh:mm").format(this);
  String get hourId => DateFormat("yyy:MM:dd:hh").format(this);
  String get dayId => DateFormat("yyy:MM:dd").format(this);
  DateTime get toLocalTime => add(timeZoneOffset);
  bool get dayIsNotPast => isAfter(
        DateTime.now().subtract(
          const Duration(days: 1),
        ),
      );
}
