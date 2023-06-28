// ignore_for_file: must_be_immutable

part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  List<AvailableTime> availableTimes;
  Set<String> dateSet;
  CalendarState(this.availableTimes, this.dateSet);

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {
  CalendarInitial(super.availableTimes, super.dateSet);
}

class CalendarLoading extends CalendarState {
  CalendarLoading(super.availableTimes, super.dateSet);
}

class CalendarError extends CalendarState {
  CalendarError(super.availableTimes, super.dateSet);
}

class CalendarSuccess extends CalendarState {
  CalendarSuccess(super.availableTimes, super.dateSet);
}
