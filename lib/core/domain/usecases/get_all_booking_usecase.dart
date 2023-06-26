import 'package:admin/core/domain/repositories/booking_repository.dart';
import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';

class GetAllBookingUsecase extends Usecase {
  final BookingRepository repo;

  GetAllBookingUsecase(this.repo);
  @override
  AsyncErrorOr call() => repo.allBookings();
}
