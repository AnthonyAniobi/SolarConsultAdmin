import 'package:admin/core/data/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key, required this.booking});
  final Booking booking;
  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
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
              Wrap(
                children: booking.images
                    .map(
                      (e) => Image.network(
                        e,
                        width: 40.w,
                        height: 40.w,
                        loadingBuilder: (context, child, event) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
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
      text: TextSpan(
        children: [
          TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.w500)),
          TextSpan(
              text: content, style: TextStyle(fontWeight: FontWeight.w400)),
        ],
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
