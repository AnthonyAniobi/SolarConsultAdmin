import 'package:admin/core/data/models/booking.dart';
import 'package:flutter/material.dart';

class BookingsDetailScreen extends StatefulWidget {
  const BookingsDetailScreen({super.key, required this.booking});
  final Booking booking;
  @override
  State<BookingsDetailScreen> createState() => _BookingsDetailScreenState();
}

class _BookingsDetailScreenState extends State<BookingsDetailScreen> {
  late Booking booking;
  @override
  void initState() {
    super.initState();
    booking = widget.booking;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Detail"),
      ),
      body: Column(
        children: [
          TitleDescription(
            title: "Booking Id: ",
            content: booking.bookingId,
          ),
          TitleDescription(
            title: "User Name: ",
            content: "${booking.firstName} ${booking.lastName}",
          ),
          TitleDescription(
            title: "Booking Id: ",
            content: booking.bookingId,
          ),
        ],
      ),
    );
  }
}

class TitleDescription extends StatelessWidget {
  final String title;
  final String content;

  const TitleDescription({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: content),
    ]));
  }
}
