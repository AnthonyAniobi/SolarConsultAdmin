part of 'bookings_bloc.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object> get props => [];
}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsError extends BookingsState {
  final String message;

  const BookingsError(this.message);
  @override
  List<Object> get props => [message];
}

class BookingsSuccess extends BookingsState {
  final List<Booking> bookings;

  const BookingsSuccess(this.bookings);

  @override
  List<Object> get props => [bookings];
}
