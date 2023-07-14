part of 'exchange_rates_bloc.dart';

abstract class ExchangeRatesEvent extends Equatable {
  const ExchangeRatesEvent();

  @override
  List<Object> get props => [];
}

class GetExchangeRates extends ExchangeRatesEvent {}

class AddExchangeRates extends ExchangeRatesEvent {
  final ExchangeRate rate;

  const AddExchangeRates(this.rate);

  @override
  List<Object> get props => [rate];
}

class UpdateExchangeRates extends ExchangeRatesEvent {
  final ExchangeRate rate;

  const UpdateExchangeRates(this.rate);

  @override
  List<Object> get props => [rate];
}

class DeleteExchangeRates extends ExchangeRatesEvent {
  final ExchangeRate rate;

  const DeleteExchangeRates(this.rate);

  @override
  List<Object> get props => [rate];
}
