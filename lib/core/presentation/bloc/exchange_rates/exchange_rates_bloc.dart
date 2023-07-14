import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/domain/repositories/exchange_rate_repository.dart';
import 'package:admin/core/domain/usecases/add_exchange_rate_usecase.dart';
import 'package:admin/core/domain/usecases/delete_exchange_rate_usecase.dart';
import 'package:admin/core/domain/usecases/get_exchange_rate_usecase.dart';
import 'package:admin/core/domain/usecases/update_exchange_rate_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exchange_rates_event.dart';
part 'exchange_rates_state.dart';

class ExchangeRatesBloc extends Bloc<ExchangeRatesEvent, ExchangeRatesState> {
  final ExchangeRateRepository repo;

  ExchangeRatesBloc(this.repo) : super(const ExchangeRatesInitial([])) {
    on<GetExchangeRates>(_getExchangeRate);
    on<AddExchangeRates>(_addExchangeRate);
    on<UpdateExchangeRates>(_updateExchangeRate);
    on<DeleteExchangeRates>(_deleteExchangeRate);
  }

  void _getExchangeRate(
      GetExchangeRates event, Emitter<ExchangeRatesState> emit) async {
    emit(ExchangeRatesLoading(state.rates));
    final result = await GetExchaneRateUsecase(repo).call();
    result.fold((left) => ExchangeRatesError(left.message, state.rates),
        (right) => emit(ExchangeRatesSuccess(right)));
  }

  void _addExchangeRate(
      AddExchangeRates event, Emitter<ExchangeRatesState> emit) async {
    emit(ExchangeRatesLoading(state.rates));
    final result = await AddExchaneRateUsecase(repo, event.rate).call();
    result.fold(
      (left) => emit(ExchangeRatesError(left.message, state.rates)),
      (right) => emit(
        ExchangeRatesSuccess(state.rates..add(event.rate)),
      ),
    );
  }

  void _updateExchangeRate(
      UpdateExchangeRates event, Emitter<ExchangeRatesState> emit) async {
    emit(ExchangeRatesLoading(state.rates));
    final result = await UpdateExchaneRateUsecase(repo, event.rate).call();
    result.fold(
      (left) => emit(ExchangeRatesError(left.message, state.rates)),
      (right) => emit(
        ExchangeRatesSuccess(
          state.rates.map((rt) {
            if (rt.currency == event.rate.currency) {
              return event.rate;
            } else {
              return rt;
            }
          }).toList(),
        ),
      ),
    );
  }

  void _deleteExchangeRate(
      DeleteExchangeRates event, Emitter<ExchangeRatesState> emit) async {
    emit(ExchangeRatesLoading(state.rates));
    final result = await DeleteExchaneRateUsecase(repo, event.rate).call();
    result.fold(
      (left) => emit(ExchangeRatesError(left.message, state.rates)),
      (right) => emit(
        ExchangeRatesSuccess(
          state.rates
              .where((rt) => rt.currency != event.rate.currency)
              .toList(),
        ),
      ),
    );
  }
}
