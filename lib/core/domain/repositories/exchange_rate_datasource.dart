import 'package:admin/core/data/models/exchange_rates.dart';

abstract class ExchangeRateDatasource {
  Future<List<ExchangeRate>> allExchangeRate();
  Future<void> addExchangeRate(ExchangeRate exchangeRate);
  Future<void> updateExchangeRate(ExchangeRate exchangeRate);
  Future<void> deleteExchangeRate(ExchangeRate exchangeRate);
}
