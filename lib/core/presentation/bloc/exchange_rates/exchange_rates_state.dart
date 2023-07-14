part of 'exchange_rates_bloc.dart';

abstract class ExchangeRatesState extends Equatable {
  final List<ExchangeRate> rates;
  const ExchangeRatesState(this.rates);

  @override
  List<Object> get props => [rates];
}

class ExchangeRatesInitial extends ExchangeRatesState {
  const ExchangeRatesInitial(super.rates);
}

class ExchangeRatesLoading extends ExchangeRatesState {
  const ExchangeRatesLoading(super.rates);
}

class ExchangeRatesError extends ExchangeRatesState {
  final String message;
  const ExchangeRatesError(this.message, super.rates);
}

class ExchangeRatesSuccess extends ExchangeRatesState {
  const ExchangeRatesSuccess(super.rates);
}
