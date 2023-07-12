import 'package:admin/core/data/models/time_period.dart';
import 'package:equatable/equatable.dart';

class TimePeriodRange extends Equatable {
  final _begin = "begin_time";
  final _finish = "finish_time";

  late final TimePeriod begin;
  late final TimePeriod finish;

  TimePeriodRange({required this.begin, required this.finish})
      : assert(finish.isGreater(begin));

  TimePeriodRange.fromMap(Map<String, dynamic> mapData) {
    begin = TimePeriod.fromMap(mapData[_begin]);
    finish = TimePeriod.fromMap(mapData[_finish]);
  }

  int get startHour => begin.hour;
  int get startMin => begin.minute;

  Map toMap() => {
        _begin: begin.toMap(),
        _finish: finish.toMap(),
      };

  @override
  List<Object?> get props => [begin, finish];

  @override
  String toString() {
    return "${begin.toString()} -> ${finish.toString()}";
  }

  static List<TimePeriodRange> all(int hour) => [
        TimePeriodRange(
            begin: TimePeriod(hour: hour, minute: 0),
            finish: TimePeriod(hour: hour, minute: 20)),
        TimePeriodRange(
            begin: TimePeriod(hour: hour, minute: 30),
            finish: TimePeriod(hour: hour, minute: 50)),
      ];
}
