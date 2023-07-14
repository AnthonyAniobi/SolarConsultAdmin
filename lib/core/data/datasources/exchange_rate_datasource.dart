import 'package:admin/core/data/models/app_error.dart';
import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/domain/repositories/exchange_rate_datasource.dart';
import 'package:admin/core/extensions/exchange_rate_list_extension.dart';
import 'package:firebase_database/firebase_database.dart';

class ExchageRateDatasourceImpl extends ExchangeRateDatasource {
  static const String _dbName = "exchange_rate";

  @override
  Future<void> addExchangeRate(ExchangeRate exchangeRate) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("$_dbName/${exchangeRate.currency}");
    await ref.set(exchangeRate.toMap());
  }

  @override
  Future<List<ExchangeRate>> allExchangeRate() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(_dbName).get();
    if (snapshot.exists) {
      Map sMap = snapshot.value as Map;
      List<Map> snapshotList = sMap.values.map((e) => e as Map).toList();
      List<ExchangeRate> allRates = snapshotList
          .map<ExchangeRate>((mapData) => ExchangeRate.fromMap(mapData))
          .toList();
      return allRates.priceFirstList;
    } else {
      throw AppError('Snapshot is empty');
    }
  }

  @override
  Future<void> deleteExchangeRate(ExchangeRate exchangeRate) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("$_dbName/${exchangeRate.currency}");
    await ref.remove();
  }

  @override
  Future<void> updateExchangeRate(ExchangeRate exchangeRate) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("$_dbName/${exchangeRate.currency}");
    await ref.set(exchangeRate.toMap());
  }
}
