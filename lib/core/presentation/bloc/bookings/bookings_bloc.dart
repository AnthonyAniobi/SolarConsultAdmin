import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/domain/repositories/booking_repository.dart';
import 'package:admin/core/domain/usecases/create_booking_usecase.dart';
import 'package:admin/core/domain/usecases/delete_booking_usecase.dart';
import 'package:admin/core/domain/usecases/get_all_booking_usecase.dart';
import 'package:admin/core/domain/usecases/update_booking_usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final BookingRepository repo;
  BookingsBloc(this.repo) : super(BookingsInitial()) {
    on<CreateNewBookingEvent>(_createBooking);
    on<GetAllBookingEvent>(_getAllBooking);
    on<DeleteBookingEvent>(_deleteBooking);
    on<UpdateBookingEvent>(_updateBooking);
  }

  void _getAllBooking(
      GetAllBookingEvent event, Emitter<BookingsState> emit) async {
    emit(BookingsLoading());
    final result = await GetAllBookingUsecase(repo).call();
    result.fold(
      (left) => emit(
        BookingsError(left.message),
      ),
      (right) => emit(
        BookingsSuccess(right),
      ),
    );
  }

  void _createBooking(
      CreateNewBookingEvent event, Emitter<BookingsState> emit) async {
    if (state is BookingsSuccess) {
      final state = this.state as BookingsSuccess;
      final bookings = state.bookings;
      emit(BookingsLoading());
      final result = await CreateBookingUsecase(repo, event.booking).call();
      result.fold(
        (left) => emit(
          BookingsError(left.message),
        ),
        (right) => emit(
          BookingsSuccess(bookings),
        ),
      );
    }
  }

  void _deleteBooking(
      DeleteBookingEvent event, Emitter<BookingsState> emit) async {
    if (state is BookingsSuccess) {
      final state = this.state as BookingsSuccess;
      final bookings = state.bookings;
      emit(BookingsLoading());
      final result = await DeleteBookingUsecase(repo, event.booking).call();
      result.fold(
        (left) => emit(
          BookingsError(left.message),
        ),
        (right) => emit(
          BookingsSuccess(bookings),
        ),
      );
    }
  }

  void _updateBooking(
      UpdateBookingEvent event, Emitter<BookingsState> emit) async {
    if (state is BookingsSuccess) {
      final state = this.state as BookingsSuccess;
      final bookings = state.bookings;
      emit(BookingsLoading());
      final result = await UpdateBookingUsecase(repo, event.booking).call();
      result.fold(
        (left) => emit(
          BookingsError(left.message),
        ),
        (right) => emit(
          BookingsSuccess(bookings),
        ),
      );
    }
  }
}
