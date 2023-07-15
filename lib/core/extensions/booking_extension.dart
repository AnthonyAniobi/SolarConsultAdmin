import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/data/models/time_period.dart';
import 'package:admin/core/data/models/time_period_range.dart';

extension BookingExtension on Booking {
  Booking get toLocalTimezone {
    Duration timeZone = DateTime.now().timeZoneOffset;
    final beginTime = date.copyWith(hour: timeRange.begin.hour);
    final localBeginTime = beginTime.add(timeZone);
    final localEndTime = beginTime.add(const Duration(minutes: 20));
    final booking = copy(
        timeRange: TimePeriodRange(
            begin: TimePeriod(
              hour: localBeginTime.hour,
              minute: localBeginTime.minute,
            ),
            finish: TimePeriod(
              hour: localEndTime.hour,
              minute: localEndTime.minute,
            )));
    return booking;
  }

  Booking get toUtcTimezone {
    Duration timeZone = DateTime.now().timeZoneOffset;
    final beginTime = date.copyWith(hour: timeRange.begin.hour);
    final localBeginTime = beginTime.subtract(timeZone);
    final localEndTime = beginTime.add(const Duration(minutes: 20));
    final booking = copy(
        timeRange: TimePeriodRange(
            begin: TimePeriod(
                hour: localBeginTime.hour, minute: localBeginTime.minute),
            finish: TimePeriod(
              hour: localEndTime.hour,
              minute: localEndTime.minute,
            )));
    return booking;
  }
}
