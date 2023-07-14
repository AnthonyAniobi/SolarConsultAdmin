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
}
