import 'package:admin/core/extensions/datetime_extension.dart';

class AvailableTime {
  final String _date = "date_time";
  final String _hours = "hours_available";

  late final DateTime date;
  late final List<int> hours;

  AvailableTime({required this.date, required this.hours});

  AvailableTime.fromMap(Map data) {
    date = DateTime.fromMillisecondsSinceEpoch(data[_date]).fromUtc;
    hours = data[_hours].map<int>((h) => h as int).toList();
  }

  Map<String, dynamic> toMap() => {
        _date: date.millisecondsSinceEpoch,
        _hours: hours,
      };
}
