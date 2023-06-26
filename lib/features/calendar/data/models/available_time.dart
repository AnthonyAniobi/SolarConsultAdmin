import 'package:intl/intl.dart';

class AvailableTime {
  final String _from = "start_time";
  final String _to = "end_time";

  late final DateTime from;
  late final DateTime to;

  AvailableTime({required this.from, required this.to})
      : assert(from.isBefore(to));

  AvailableTime.fromMap(Map data) {
    from = DateTime.fromMillisecondsSinceEpoch(data[_from]);
    to = DateTime.fromMillisecondsSinceEpoch(data[_to]);
  }

  AvailableTime copy({DateTime? from, DateTime? to}) =>
      AvailableTime(from: from ?? this.from, to: to ?? this.to);

  String get id => DateFormat('yyyy:MM:dd:hh:MM').format(_toUtc(from));

  DateTime _toUtc(DateTime time) {
    final timeZone = DateTime.now().timeZoneOffset;
    return time.subtract(timeZone);
  }
}
