import 'package:admin/features/calendar/presentation/widgets/month_calendar.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Shedule"),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return MonthCalendar(
              index: index,
            );
          }),
    );
  }
}
