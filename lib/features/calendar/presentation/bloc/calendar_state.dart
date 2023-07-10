// ignore_for_file: must_be_immutable

part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  List<AvailableTime> availableTimes;
  Set<String> dateSet;
  bool updated;
  CalendarState(this.availableTimes, this.dateSet, this.updated);

  @override
  List<Object> get props => [availableTimes, updated, dateSet];
}

class CalendarInitial extends CalendarState {
  CalendarInitial(super.availableTimes, super.dateSet, super.updated);
}

class CalendarLoading extends CalendarState {
  CalendarLoading(super.availableTimes, super.dateSet, super.updated);
}

class CalendarError extends CalendarState {
  final String errorMessage;
  CalendarError(
      super.availableTimes, super.dateSet, super.updated, this.errorMessage);

  @override
  List<Object> get props => [errorMessage, availableTimes, dateSet, updated];
}

class CalendarSuccess extends CalendarState {
  CalendarSuccess(super.availableTimes, super.dateSet, super.updated);
}
