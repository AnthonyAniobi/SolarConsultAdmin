import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial([], {})) {
    on<AddAvailableTimeEvent>(_addAvailableTime);
  }

  void _addAvailableTime(
      AddAvailableTimeEvent event, Emitter<CalendarState> emit) {
    emit(
      CalendarSuccess(
        state.availableTimes..add(event.time),
        state.dateSet
          ..add(
            event.time.date.dayId,
          ),
      ),
    );
  }
}
