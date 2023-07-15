import 'package:admin/core/data/models/exchange_rates.dart';

extension ExchangeRateList on List<ExchangeRate> {
  /// list of exchange rate where price is first
  List<ExchangeRate> get priceFirstList {
    ExchangeRate priceRate = firstWhere((element) => element.isPrice);
    List<ExchangeRate> exceptRate =
        where((element) => !element.isPrice).toList();
    return [
      priceRate,
      ...exceptRate,
    ];
  }

  /// get value of price
  double get priceRate => firstWhere((element) => element.isPrice).rate;

  /// list of exchange rate without price
  List<ExchangeRate> get withoutPriceList =>
      where((element) => !element.isPrice).toList();

  /// list of only active exchange rates
  List<ExchangeRate> get activeExchangeRates =>
      withoutPriceList.where((element) => element.active).toList();
}
