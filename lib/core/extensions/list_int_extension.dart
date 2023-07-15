extension ListIntExtension on List<int> {
  List<int> get toLocalTime {
    int timezoneHour = DateTime.now().timeZoneOffset.inHours;
    return map((e) => e + timezoneHour).toList();
  }

  List<int> get toUTCTime {
    int timezoneHour = DateTime.now().timeZoneOffset.inHours;
    return map((e) => e - timezoneHour).toList();
  }
}
