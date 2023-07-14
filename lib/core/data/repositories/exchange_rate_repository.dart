import 'package:admin/core/data/models/app_error.dart';
import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/domain/repositories/exchange_rate_datasource.dart';
import 'package:admin/core/domain/repositories/exchange_rate_repository.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExchangeRateRepositoryImpl extends ExchangeRateRepository {
  final ExchangeRateDatasource datasource;

  ExchangeRateRepositoryImpl(this.datasource);

  @override
  AsyncErrorOr<void> addExchangeRate(ExchangeRate exchangeRate) async {
    try {
      final result = await datasource.addExchangeRate(exchangeRate);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  AsyncErrorOr<List<ExchangeRate>> allExchangeRate() async {
    try {
      final result = await datasource.allExchangeRate();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  AsyncErrorOr<void> deleteExchangeRate(ExchangeRate exchangeRate) async {
    try {
      final result = await datasource.deleteExchangeRate(exchangeRate);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  AsyncErrorOr<void> updateExchangeRate(ExchangeRate exchangeRate) async {
    try {
      final result = await datasource.updateExchangeRate(exchangeRate);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
