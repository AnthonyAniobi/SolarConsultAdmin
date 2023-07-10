import 'package:admin/features/calendar/data/models/available_time.dart';

abstract class CalendarDatasource {
  Future<List<AvailableTime>> getAvailableTimes();
  Future<void> updateAvailableTime(List<AvailableTime> availableTimes);
}
