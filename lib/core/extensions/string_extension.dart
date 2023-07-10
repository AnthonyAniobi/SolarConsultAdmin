extension StringExtension on String {
  DateTime get dayIdToDatetime {
    List<String> values = split(':');
    return DateTime(
      int.parse(values[0]),
      int.parse(values[1]),
      int.parse(
        values[2],
      ),
    );
  }
}
