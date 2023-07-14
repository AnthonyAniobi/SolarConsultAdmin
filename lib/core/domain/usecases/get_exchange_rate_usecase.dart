import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/domain/repositories/exchange_rate_repository.dart';
import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';

class GetExchaneRateUsecase extends Usecase {
  final ExchangeRateRepository repo;

  GetExchaneRateUsecase(this.repo);
  @override
  AsyncErrorOr<List<ExchangeRate>> call() => repo.allExchangeRate();
}
