import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/data/models/time_period_range.dart';
import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/features/bookings/presentation/widgets/time_selection_widget.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectBookingHourScreen extends StatelessWidget {
  const SelectBookingHourScreen({
    super.key,
    required this.availableTime,
    required this.bookingRange,
  });

  final AvailableTime availableTime;
  final List<Booking> bookingRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Pick Hour  ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
              TextSpan(
                  text: DateFormat("dd MMMM, yyyy").format(availableTime.date),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
            ],
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: availableTime.hours.length,
          itemBuilder: (context, index) {
            final avTime = availableTime.hours[index];
            return Card(
              margin: EdgeInsets.symmetric(
                vertical: 1.5.w,
                horizontal: 4.w,
              ),
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${toHours(avTime)}  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            color: Theme.of(context).colorScheme.onSurface,
                          )),
                    ],
                  ),
                ),
                onTap: () async {
                  await minutePicker(context, avTime);
                },
              ),
            );
          }),
    );
  }

  Future<void> minutePicker(BuildContext context, int hour) async {
    final currentHour = DateTime(
      availableTime.date.year,
      availableTime.date.month,
      availableTime.date.day,
      hour,
    );
    List<Booking> bookings = bookingRange
        .where((bk) => bk.date.hourId == currentHour.hourId)
        .toList();
    TimePeriodRange? result = await showDialog<TimePeriodRange>(
        context: context,
        builder: (context) {
          return TimeSelectionWidget(
            hour: hour,
            availableTime: availableTime,
            bookings: bookings,
          );
        });
    if (result != null) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, result);
    }
  }

  String toHours(int hours) {
    if (hours < 12) {
      return "$hours am";
    } else if (hours == 12) {
      return "$hours pm";
    } else {
      return "${hours - 12} pm";
    }
  }
}
