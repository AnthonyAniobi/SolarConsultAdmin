import 'package:equatable/equatable.dart';

class TimePeriod extends Equatable {
  final _hourKey = "hour";
  final _minuteKey = "minute";

  late final int hour;
  late final int minute;

  TimePeriod({
    required this.hour,
    required this.minute,
  });

  TimePeriod.fromDateTime(DateTime time) {
    hour = time.hour;
    minute = time.minute;
  }

  TimePeriod.fromMap(Map<String, dynamic> mapData) {
    hour = mapData[_hourKey];
    minute = mapData[_minuteKey];
  }

  bool isGreater(TimePeriod other) {
    if (hour > other.hour) {
      return true;
    } else if (hour == other.hour) {
      return minute > other.minute;
    } else {
      return true;
    }
  }

  bool isLess(TimePeriod other) {
    if (hour < other.hour) {
      return true;
    } else if (hour == other.hour) {
      return minute < other.minute;
    } else {
      return false;
    }
  }

  Map toMap() => {
        _hourKey: hour,
        _minuteKey: minute,
      };

  @override
  List<Object?> get props => [hour, minute];

  @override
  String toString() {
    return "${"$hour".padLeft(2, '0')}:${"$minute".padLeft(2, '0')}";
  }
}
