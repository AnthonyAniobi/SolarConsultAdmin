import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/domain/repositories/booking_repository.dart';
import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';

class DeleteBookingUsecase extends Usecase {
  final BookingRepository repo;
  final Booking booking;

  DeleteBookingUsecase(this.repo, this.booking);
  @override
  AsyncErrorOr call() => repo.deleteBooking(booking);
}
