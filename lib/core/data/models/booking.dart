import 'dart:typed_data';

class Booking {
  // items
  final String _bookingid = 'booking_id';
  final String _startTime = 'start_time';
  final String _firstName = 'first_name';
  final String _lastName = 'last_name';
  final String _email = 'email';
  final String _timezone = 'timezone';
  final String _endTime = 'end_time';
  final String _userId = 'user_id';
  final String _description = 'description';
  final String _images = 'images';

  static const String orderByKey = "start_time";
  static const String bookingUserId = "user_id";

  // models
  late final String bookingId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final DateTime startTime;
  late final Duration timezone;
  late final DateTime endTime;
  late final String userId;
  late final String description;
  late final List<Uint8List> images;

  Booking({
    required this.bookingId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.startTime,
    required this.timezone,
    required this.endTime,
    required this.userId,
    required this.description,
    required this.images,
  });

  Booking.fromMap(Map data) {
    bookingId = data[_bookingid];
    firstName = data[_firstName];
    lastName = data[_lastName];
    email = data[_email];
    startTime = DateTime.fromMillisecondsSinceEpoch(data[_startTime]);
    timezone = Duration(milliseconds: data[_timezone]);
    endTime = DateTime.fromMillisecondsSinceEpoch(data[_endTime]);
    userId = data[_userId];
    description = data[_description];
    images = data[_images].map((List<int> uList) => Uint8List.fromList(uList));
  }

  Map<String, dynamic> toMap() => {
        _bookingid: bookingId,
        _firstName: firstName,
        _lastName: lastName,
        _email: email,
        _startTime: startTime.millisecondsSinceEpoch,
        _timezone: timezone.inMilliseconds,
        _endTime: endTime.millisecondsSinceEpoch,
        _userId: userId,
        _description: description,
        _images: images.map((e) => e.toList()).toList(),
      };
}
