import 'package:admin/core/data/models/app_error.dart';
import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/domain/repositories/booking_datasource.dart';
import 'package:admin/core/domain/repositories/booking_repository.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingRepositoryImpl extends BookingRepository {
  final BookingDatasource datasource;

  BookingRepositoryImpl(this.datasource);
  @override
  AsyncErrorOr<void> addBooking(Booking booking) async {
    try {
      await datasource.addBooking(booking);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  AsyncErrorOr<List<Booking>> allBookings() async {
    try {
      final result = await datasource.allBookings();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  AsyncErrorOr<void> deleteBooking(Booking booking) async {
    try {
      await datasource.deleteBooking(booking);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  AsyncErrorOr<void> updateBooking(Booking booking) async {
    try {
      await datasource.updateBooking(booking);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
