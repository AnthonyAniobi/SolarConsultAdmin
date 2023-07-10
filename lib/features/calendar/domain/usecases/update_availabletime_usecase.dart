import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/domain/repositories/calendar_repository.dart';

class UpdateAvailableTimeUsecase extends Usecase {
  final CalendarRepository repo;
  final List<AvailableTime> availableTimes;

  UpdateAvailableTimeUsecase(this.repo, this.availableTimes);

  @override
  AsyncErrorOr call() => repo.updateAvailableTimes(availableTimes);
}
