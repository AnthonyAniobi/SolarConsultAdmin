part of 'bookings_bloc.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();  

  @override
  List<Object> get props => [];
}
class BookingsInitial extends BookingsState {}
