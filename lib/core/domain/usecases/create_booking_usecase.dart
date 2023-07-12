import 'dart:typed_data';

import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/domain/repositories/booking_repository.dart';
import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';

class CreateBookingUsecase extends Usecase {
  final BookingRepository repo;
  final Booking booking;
  final List<Uint8List> images;

  CreateBookingUsecase(this.repo, this.booking, this.images);
  @override
  AsyncErrorOr call() => repo.addBooking(booking, images);
}
