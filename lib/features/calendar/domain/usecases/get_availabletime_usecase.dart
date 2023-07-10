import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/domain/repositories/calendar_repository.dart';

class GetAvailableTimeUsecase extends Usecase {
  final CalendarRepository repo;

  GetAvailableTimeUsecase(this.repo);

  @override
  AsyncErrorOr<List<AvailableTime>> call() => repo.getAvailableTimes();
}
