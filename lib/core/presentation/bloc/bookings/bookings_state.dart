part of 'bookings_bloc.dart';

abstract class BookingsState extends Equatable {
  final List<Booking> bookings;
  const BookingsState(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class BookingsInitial extends BookingsState {
  const BookingsInitial(super.bookings);
}

class BookingsLoading extends BookingsState {
  const BookingsLoading(super.bookings);
}

class BookingsError extends BookingsState {
  final String message;
  const BookingsError(this.message, super.bookings);

  @override
  List<Object> get props => [message, bookings];
}

class BookingsSuccess extends BookingsState {
  const BookingsSuccess(super.bookings);
}
