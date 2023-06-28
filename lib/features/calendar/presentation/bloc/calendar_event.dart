part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class AddAvailableTimeEvent extends CalendarEvent {
  final AvailableTime time;

  const AddAvailableTimeEvent(this.time);

  @override
  List<Object> get props => [time];
}
