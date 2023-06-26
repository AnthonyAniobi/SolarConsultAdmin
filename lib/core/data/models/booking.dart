import 'dart:typed_data';

class Booking {
  // items
  final String _bookingid = 'booking_id';
  final String _startTime = 'start_time';
  final String _timezone = 'timezone';
  final String _minutes = 'minutes';
  final String _userId = 'user_id';
  final String _description = 'description';
  final String _images = 'images';

  static const String orderByKey = "start_time";
  static const String bookingUserId = "user_id";

  // models
  late final String bookingId;
  late final String firstName;
  late final String lastName;
  late final DateTime startTime;
  late final Duration timezone;
  late final int minutes;
  late final String userId;
  late final String description;
  late final List<Uint8List> images;

  Booking({
    required this.bookingId,
    required this.startTime,
    required this.timezone,
    required this.minutes,
    required this.userId,
    required this.description,
    required this.images,
  });

  Booking.fromMap(Map data) {
    bookingId = data[_bookingid];
    startTime = DateTime.fromMillisecondsSinceEpoch(data[_startTime]);
    timezone = Duration(milliseconds: data[_timezone]);
    minutes = data[_minutes];
    userId = data[_userId];
    description = data[_description];
    images = data[_images].map((List<int> uList) => Uint8List.fromList(uList));
  }

  Map<String, dynamic> toMap() => {
        _bookingid: bookingId,
        _startTime: startTime.millisecondsSinceEpoch,
        _timezone: timezone.inMilliseconds,
        _minutes: minutes,
        _userId: userId,
        _description: description,
        _images: images.map((e) => e.toList()).toList(),
      };
}
