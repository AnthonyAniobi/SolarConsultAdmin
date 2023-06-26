part of 'bookings_bloc.dart';

abstract class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

/// get all bookings
class GetAllBookingEvent extends BookingsEvent {}

/// delete booking
class DeleteBookingEvent extends BookingsEvent {
  final Booking booking;

  const DeleteBookingEvent(this.booking);

  @override
  List<Object> get props => [booking];
}

/// create a new booking
class CreateNewBookingEvent extends BookingsEvent {
  final Booking booking;

  const CreateNewBookingEvent(this.booking);

  @override
  List<Object> get props => [booking];
}

/// update booking
class UpdateBookingEvent extends BookingsEvent {
  final Booking booking;

  const UpdateBookingEvent(this.booking);

  @override
  List<Object> get props => [booking];
}
