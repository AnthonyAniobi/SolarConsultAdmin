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

class AddManyAvailableTimeEvent extends CalendarEvent {
  final List<AvailableTime> avTimes;

  const AddManyAvailableTimeEvent(this.avTimes);

  @override
  List<Object> get props => [avTimes];
}

class RemoveAvailableTimeEvent extends CalendarEvent {
  final DateTime time;

  const RemoveAvailableTimeEvent(this.time);

  @override
  List<Object> get props => [time];
}

class DeleteAllAvailableTimeEvent extends CalendarEvent {}

class GetAvailableTimeEvent extends CalendarEvent {}

class UpdateAvailableTimeEvent extends CalendarEvent {}
