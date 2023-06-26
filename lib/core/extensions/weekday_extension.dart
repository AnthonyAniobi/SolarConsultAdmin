import 'package:admin/core/enums/weekdays.dart';

extension WeekdayExtension on Weekdays {
  String get name {
    switch (this) {
      case Weekdays.sun:
        return 'sun';
      case Weekdays.mon:
        return 'mon';
      case Weekdays.tue:
        return 'tue';
      case Weekdays.wed:
        return 'wed';
      case Weekdays.thu:
        return 'thu';
      case Weekdays.fri:
        return 'fri';
      case Weekdays.sat:
        return 'sat';
    }
  }
}
