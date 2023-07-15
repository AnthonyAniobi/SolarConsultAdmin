import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ExchangeRate extends Equatable {
  // ids
  static const String _currencyId = 'currency';
  static const String _rateId = 'rate';
  static const String _nameId = 'name';
  static const String _activeId = 'active';

  //
  late String currency;
  late String name;
  late double rate;
  late bool active;

  ExchangeRate({
    required this.currency,
    required this.rate,
    required this.active,
    required this.name,
  });

  ExchangeRate.fromMap(Map mapData) {
    currency = mapData[_currencyId] as String;
    rate = double.parse(mapData[_rateId].toString());
    active = mapData[_activeId] as bool;
    name = mapData[_nameId];
  }

  @override
  List<Object?> get props => [currency, rate, active, name];

  bool get isPrice => currency == priceId;

  static String priceId = "PRICE";

  Map toMap() => {
        _currencyId: currency,
        _rateId: rate,
        _activeId: active,
        _nameId: name,
      };
}
