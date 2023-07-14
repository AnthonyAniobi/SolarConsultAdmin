import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/domain/repositories/exchange_rate_repository.dart';
import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';

class DeleteExchaneRateUsecase extends Usecase {
  final ExchangeRateRepository repo;
  final ExchangeRate exchangeRate;

  DeleteExchaneRateUsecase(this.repo, this.exchangeRate);
  @override
  AsyncErrorOr call() => repo.deleteExchangeRate(exchangeRate);
}
