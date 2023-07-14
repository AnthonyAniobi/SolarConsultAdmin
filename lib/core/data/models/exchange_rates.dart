import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ExchangeRate extends Equatable {
  // ids
  static const String _currencyId = 'currency';
  static const String _rateId = 'rate';
  static const String _activeId = 'active';

  //
  late String currency;
  late double rate;
  late bool active;

  ExchangeRate(
      {required this.currency, required this.rate, required this.active});

  ExchangeRate.fromMap(Map mapData) {
    currency = mapData[_currencyId] as String;
    rate = double.parse(mapData[_rateId].toString());
    active = mapData[_activeId] as bool;
  }

  @override
  List<Object?> get props => [currency, rate, active];

  bool get isPrice => currency == priceId;

  static String priceId = "PRICE";

  Map toMap() => {
        _currencyId: currency,
        _rateId: rate,
        _activeId: active,
      };
}
