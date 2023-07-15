import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/core/extensions/list_int_extension.dart';

class AvailableTime {
  final String _date = "date_time";
  final String _hours = "hours_available";

  late final DateTime date;
  late final List<int> hours;

  AvailableTime({required this.date, required this.hours});

  AvailableTime.fromMap(Map data) {
    List<int> allHours = data[_hours].map<int>((h) => h as int).toList();
    date = DateTime.fromMillisecondsSinceEpoch(data[_date]).toLocalTime;
    hours = allHours.toLocalTime;
  }

  Map<String, dynamic> toMap() => {
        _date: date.toUtc().millisecondsSinceEpoch,
        _hours: hours.toUTCTime, // convert to utc before sending to online
      };
}
