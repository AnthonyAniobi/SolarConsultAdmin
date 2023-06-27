import 'package:admin/features/calendar/presentation/pages/edit_calendar_screen.dart';
import 'package:admin/features/calendar/presentation/widgets/month_calendar.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Schedule"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editNavigator(context);
        },
        child: const Icon(Icons.edit),
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

  void editNavigator(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const EditCalendarScreen()),
    );
  }
}
