import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/utils/app_config.dart';

abstract class ExchangeRateRepository {
  AsyncErrorOr<List<ExchangeRate>> allExchangeRate();
  AsyncErrorOr<void> addExchangeRate(ExchangeRate exchangeRate);
  AsyncErrorOr<void> updateExchangeRate(ExchangeRate exchangeRate);
  AsyncErrorOr<void> deleteExchangeRate(ExchangeRate exchangeRate);
}
