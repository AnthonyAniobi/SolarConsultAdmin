import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/domain/repositories/exchange_rate_repository.dart';
import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';

class UpdateExchaneRateUsecase extends Usecase {
  final ExchangeRateRepository repo;
  final ExchangeRate exchangeRate;

  UpdateExchaneRateUsecase(this.repo, this.exchangeRate);
  @override
  AsyncErrorOr call() => repo.updateExchangeRate(exchangeRate);
}
