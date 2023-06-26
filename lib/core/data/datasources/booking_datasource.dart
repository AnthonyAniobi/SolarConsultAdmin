import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/domain/repositories/booking_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDatasourceImpl extends BookingDatasource {
  static const String _collectionName = "booking";
  static const int _limit = 100;
  @override
  Future<void> addBooking(Booking booking) async {
    final docUser = FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(booking.bookingId);
    final json = booking.toMap();
    await docUser.set(json);
  }

  @override
  Future<List<Booking>> allBookings() async {
    final result = await FirebaseFirestore.instance
        .collection(_collectionName)
        .limit(_limit)
        .orderBy(Booking.orderByKey)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map<Booking>((doc) => Booking.fromMap(doc.data()))
            .toList())
        .first;
    return result;
  }

  @override
  Future<void> deleteBooking(Booking booking) async {
    final docUser = FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(booking.bookingId);
    await docUser.delete();
  }

  @override
  Future<void> updateBooking(Booking booking) async {
    final docUser = FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(booking.bookingId);
    await docUser.update(booking.toMap());
  }
}
