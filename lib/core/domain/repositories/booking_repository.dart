import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/utils/app_config.dart';

abstract class BookingRepository {
  AsyncErrorOr<List<Booking>> allBookings();
  AsyncErrorOr<void> addBooking(Booking booking);
  AsyncErrorOr<void> updateBooking(Booking booking);
  AsyncErrorOr<void> deleteBooking(Booking booking);
}
