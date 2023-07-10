import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';

abstract class CalendarRepository {
  AsyncErrorOr<List<AvailableTime>> getAvailableTimes();
  AsyncErrorOr<void> updateAvailableTimes(List<AvailableTime> availableTimes);
}
