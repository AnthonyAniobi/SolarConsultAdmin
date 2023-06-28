import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get minuteId => DateFormat("yyy:MM:dd:hh:mm").format(this);
  String get dayId => DateFormat("yyy:MM:dd").format(this);
  DateTime get fromUtc => add(timeZoneOffset);
}
