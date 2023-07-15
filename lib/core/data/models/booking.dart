import 'package:admin/core/data/models/time_period_range.dart';
import 'package:admin/core/extensions/booking_extension.dart';

class Booking {
  // items
  final String _bookingid = 'booking_id';
  final String _timeRangeName = 'time_range';
  final String _dateName = 'date';
  final String _firstName = 'first_name';
  final String _lastName = 'last_name';
  final String _email = 'email';
  final String _userId = 'user_id';
  final String _description = 'description';
  final String _images = 'images';
  final String _meetingLink = 'meeting_link';
  static const String orderByKey = "date";
  static const String bookingUserId = "user_id";

  // models
  late final String bookingId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final DateTime date;
  late final TimePeriodRange timeRange;
  late final String meetingLink;
  late final String userId;
  late final String description;
  late final List<String> images;

  Booking({
    required this.bookingId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.date,
    required this.meetingLink,
    required this.timeRange,
    required this.userId,
    required this.description,
    required this.images,
  });

  Booking.fromMap(Map data) {
    // get information in server
    Booking serverBooking = Booking(
      bookingId: data[_bookingid],
      firstName: data[_firstName],
      lastName: data[_lastName],
      email: data[_email],
      date: DateTime.fromMillisecondsSinceEpoch(data[_dateName]),
      meetingLink: data[_meetingLink] ?? "",
      timeRange: TimePeriodRange.fromMap(data[_timeRangeName]),
      userId: data[_userId],
      description: data[_description],
      images: List<String>.from(data[_images]),
    );
    // convert to local time
    Booking localBooking = serverBooking.toLocalTimezone;
    // parse information to current booking
    bookingId = localBooking.bookingId;
    firstName = localBooking.firstName;
    lastName = localBooking.lastName;
    email = localBooking.email;
    date = localBooking.date;
    meetingLink = localBooking.meetingLink;
    timeRange = localBooking.timeRange;
    userId = localBooking.userId;
    description = localBooking.description;
    images = localBooking.images;
  }

  Map<String, dynamic> toMap() {
    Booking utcBooking = toUtcTimezone;
    return {
      _bookingid: utcBooking.bookingId,
      _firstName: utcBooking.firstName,
      _lastName: utcBooking.lastName,
      _email: utcBooking.email,
      _dateName: utcBooking.date.millisecondsSinceEpoch,
      _meetingLink: utcBooking.meetingLink,
      _timeRangeName: utcBooking.timeRange.toMap(),
      _userId: utcBooking.userId,
      _description: utcBooking.description,
      _images: utcBooking.images,
    };
  }

  Booking copy({
    String? bookingId,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? date,
    TimePeriodRange? timeRange,
    String? meetingLink,
    String? userId,
    String? description,
    List<String>? images,
  }) =>
      Booking(
          bookingId: bookingId ?? this.bookingId,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          email: email ?? this.email,
          date: date ?? this.date,
          meetingLink: meetingLink ?? this.meetingLink,
          timeRange: timeRange ?? this.timeRange,
          userId: userId ?? this.userId,
          description: description ?? this.description,
          images: images ?? this.images);
}
