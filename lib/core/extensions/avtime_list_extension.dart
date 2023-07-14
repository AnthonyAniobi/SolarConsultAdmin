import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/core/extensions/string_extension.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';

extension AvailableTimeExtension on List<AvailableTime> {
  Future<List<AvailableTime>> toTimeZone(Duration timeZone) async {
    List<DateTime> alltimes = [];

    for (int t = 0; t < length; t++) {
      for (int h = 0; h < elementAt(t).hours.length; h++) {
        DateTime currentDay = elementAt(t).date;
        int currenthour = elementAt(t).hours[h];
        DateTime currentDayHour = DateTime(
          currentDay.year,
          currentDay.month,
          currentDay.day,
          currenthour,
        );
        DateTime localTime = currentDayHour.add(timeZone);
        alltimes.add(localTime);
      }
    }
    Map<String, List<int>> avTimeMap = <String, List<int>>{};
    for (int i = 0; i < alltimes.length; i++) {
      DateTime iTime = alltimes[i];
      if (avTimeMap.containsKey(iTime.dayId)) {
        List<int> allHours = avTimeMap[iTime.dayId]!;
        avTimeMap[iTime.dayId] = [...allHours, iTime.hour];
      } else {
        avTimeMap[iTime.dayId] = [iTime.hour];
      }
    }
    List<AvailableTime> resultAvTime = avTimeMap.entries
        .map<AvailableTime>((MapEntry<String, List<int>> mEntry) {
      DateTime date = mEntry.key.dayIdToDatetime;
      List<int> allHours = mEntry.value;
      return AvailableTime(date: date, hours: allHours);
    }).toList();

    return resultAvTime;
  }
}
