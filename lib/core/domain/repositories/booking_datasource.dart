import 'package:admin/core/data/models/booking.dart';

abstract class BookingDatasource {
  Future<List<Booking>> allBookings();
  Future<void> addBooking(Booking booking);
  Future<void> updateBooking(Booking booking);
  Future<void> deleteBooking(Booking booking);
}
