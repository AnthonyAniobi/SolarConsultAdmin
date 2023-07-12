import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/data/models/time_period_range.dart';
import 'package:admin/core/presentation/widgets/custom_alert_dialog.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimeSelectionWidget extends StatefulWidget {
  const TimeSelectionWidget(
      {super.key,
      required this.hour,
      required this.availableTime,
      required this.bookings});

  final int hour;
  final AvailableTime availableTime;
  final List<Booking> bookings;

  @override
  State<TimeSelectionWidget> createState() => _TimeSelectionWidgetState();
}

class _TimeSelectionWidgetState extends State<TimeSelectionWidget> {
  TimePeriodRange? selectedPeriod;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: toHours(widget.hour),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                )),
            TextSpan(
                text: DateFormat(" dd MMMM, yyyy")
                    .format(widget.availableTime.date),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.onSurface,
                )),
          ])),
          const Text("pick time slot for professional consultation"),
          ...TimePeriodRange.all(widget.hour).map(
            (timePeriod) => _tileSelection(timePeriod),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // print('object');
                  // print(widget.bookings);
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              ),
              if (widget.bookings.length <= 1)
                ElevatedButton(
                  onPressed: () {
                    if (selectedPeriod == null) {
                      CustomAlertDialog.basic(
                          context, "you have not selected a session");
                      return;
                    }
                    Navigator.pop(context, selectedPeriod);
                  },
                  child: const Text("Book Time slot"),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Card _tileSelection(TimePeriodRange timePeriod) {
    bool booked =
        widget.bookings.indexWhere((bk) => bk.timeRange == timePeriod) != (-1);
    bool selected = selectedPeriod == timePeriod;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 1.5.w,
      ),
      child: ListTile(
        onTap: () {
          if (booked) {
            CustomAlertDialog.basic(context,
                "Time range is already booked, please select another time slot");
          } else {
            if (selected) {
              selectedPeriod = null;
            } else {
              selectedPeriod = timePeriod;
            }
            setState(() {});
          }
        },
        tileColor: selected
            ? Colors.greenAccent.shade200
            : Theme.of(context).colorScheme.surface,
        title: Text(
          timePeriod.toString(),
          style: TextStyle(
            decoration: booked ? TextDecoration.lineThrough : null,
            color: booked ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
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
