import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/domain/repositories/exchange_rate_repository.dart';
import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';

class AddExchaneRateUsecase extends Usecase {
  final ExchangeRateRepository repo;
  final ExchangeRate exchangeRate;

  AddExchaneRateUsecase(this.repo, this.exchangeRate);
  @override
  AsyncErrorOr call() => repo.addExchangeRate(exchangeRate);
}
