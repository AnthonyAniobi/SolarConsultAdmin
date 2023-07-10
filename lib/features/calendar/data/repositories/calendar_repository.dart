import 'package:admin/core/data/models/app_error.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/domain/repositories/calendar_datasource.dart';
import 'package:admin/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_core/firebase_core.dart';

class CalendarRepositoryImpl extends CalendarRepository {
  final CalendarDatasource datasource;

  CalendarRepositoryImpl(this.datasource);
  @override
  AsyncErrorOr<List<AvailableTime>> getAvailableTimes() async {
    try {
      final result = await datasource.getAvailableTimes();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(AppError(e.message ?? "",),);
    } catch (e) {
      return Left(AppError(e.toString(),),);
    }
  }

  @override
  AsyncErrorOr<void> updateAvailableTimes(
      List<AvailableTime> availableTimes) async {
    try {
      final result = await datasource.updateAvailableTime(availableTimes);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(AppError(e.message ?? "",),);
    } catch (e) {
      return Left(AppError(e.toString(),),);
    }
  }
}
