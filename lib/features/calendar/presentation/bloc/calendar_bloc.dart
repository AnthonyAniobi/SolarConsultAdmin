import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:admin/features/calendar/domain/usecases/get_availabletime_usecase.dart';
import 'package:admin/features/calendar/domain/usecases/update_availabletime_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository repo;

  CalendarBloc(this.repo) : super(CalendarInitial([], {}, false)) {
    on<AddAvailableTimeEvent>(_addAvailableTime);
    on<AddManyAvailableTimeEvent>(_addManyAvailableTime);
    on<RemoveAvailableTimeEvent>(_removeAvailableTime);
    on<GetAvailableTimeEvent>(_getAvailableTime);
    on<UpdateAvailableTimeEvent>(_updateAvailableTime);
    on<DeleteAllAvailableTimeEvent>(_deleteAllAvailableTime);
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
        true,
      ),
    );
  }

  void _deleteAllAvailableTime(
      DeleteAllAvailableTimeEvent event, Emitter<CalendarState> emit) {
    emit(
      CalendarSuccess(
        state.availableTimes..clear(),
        state.dateSet..clear(),
        true,
      ),
    );
  }

  void _addManyAvailableTime(
      AddManyAvailableTimeEvent event, Emitter<CalendarState> emit) {
    emit(
      CalendarSuccess(
        event.avTimes,
        event.avTimes.map((at) => at.date.dayId).toSet(),
        true,
      ),
    );
  }

  void _removeAvailableTime(
      RemoveAvailableTimeEvent event, Emitter<CalendarState> emit) {
    emit(
      CalendarSuccess(
        state.availableTimes
          ..removeWhere((element) => element.date.dayId == event.time.dayId),
        state.dateSet
          ..remove(
            event.time.dayId,
          ),
        true,
      ),
    );
  }

  void _getAvailableTime(
      GetAvailableTimeEvent event, Emitter<CalendarState> emit) async {
    emit(
      CalendarLoading(
        state.availableTimes,
        state.dateSet,
        state.updated,
      ),
    );
    final result = await GetAvailableTimeUsecase(repo).call();
    result.fold(
      (left) => emit(
        CalendarError(
          state.availableTimes,
          state.dateSet,
          state.updated,
          left.message,
        ),
      ),
      (right) {
        return emit(
          CalendarSuccess(
            right,
            right.map((avTime) => avTime.date.dayId).toSet(),
            false,
          ),
        );
      },
    );
  }

  void _updateAvailableTime(
      UpdateAvailableTimeEvent event, Emitter<CalendarState> emit) async {
    emit(
      CalendarLoading(
        state.availableTimes,
        state.dateSet,
        state.updated,
      ),
    );
    final result =
        await UpdateAvailableTimeUsecase(repo, state.availableTimes).call();
    result.fold(
      (left) => emit(
        CalendarError(
          state.availableTimes,
          state.dateSet,
          false,
          left.message,
        ),
      ),
      (right) {
        return emit(
          CalendarSuccess(
            state.availableTimes,
            state.dateSet,
            true,
          ),
        );
      },
    );
  }
}
