import 'package:admin/core/data/models/app_error.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/domain/repositories/calendar_datasource.dart';
import 'package:firebase_database/firebase_database.dart';

class CalendarDatasourceImpl extends CalendarDatasource {
  final String dbName = "availableTimes";

  @override
  Future<List<AvailableTime>> getAvailableTimes() async {
    // FirebaseDatabase database = FirebaseDatabase.instance;
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(dbName).get();
    if (snapshot.exists) {
      List sList = snapshot.value as List;
      List<Map> snapshotList = sList.map((e) => e as Map).toList();
      List<AvailableTime> allTimes = snapshotList
          .map<AvailableTime>((mapData) => AvailableTime.fromMap(mapData))
          .toList();
      return allTimes;
    } else {
      throw AppError('Snapshot is empty');
    }
  }

  @override
  Future<void> updateAvailableTime(List<AvailableTime> availableTimes) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(dbName);
    await ref.set(
      availableTimes
          .map(
            (avTime) => avTime.toMap(),
          )
          .toList(),
    );
  }
}
