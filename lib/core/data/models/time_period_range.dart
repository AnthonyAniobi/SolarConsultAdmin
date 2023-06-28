import 'package:admin/core/data/models/time_period.dart';

class TimePeriodRange {
  final _begin = "begin";
  final _finish = "finish";

  late final TimePeriod begin;
  late final TimePeriod finish;

  TimePeriodRange({required this.begin, required this.finish})
      : assert(finish.isGreater(begin));

  TimePeriodRange.fromMap(Map<String, dynamic> mapData) {
    begin = TimePeriod.fromMap(mapData[_begin]);
    finish = TimePeriod.fromMap(mapData[_finish]);
  }

  int get hourDifference => finish.hour - begin.hour;

  Map toMap() => {
        _begin: begin.toMap(),
        _finish: finish.toMap(),
      };
}
