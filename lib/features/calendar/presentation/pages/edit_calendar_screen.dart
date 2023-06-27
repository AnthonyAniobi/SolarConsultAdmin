import 'package:admin/features/calendar/presentation/widgets/check_edit_button.dart';
import 'package:admin/features/calendar/presentation/widgets/edit_month_calendar.dart';
import 'package:flutter/material.dart';

class EditCalendarScreen extends StatelessWidget {
  const EditCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Calendar Schedule"),
      ),
      bottomNavigationBar: Row(
        children: [
          CheckEditButton(
            text: "Choose Day",
            onPressed: () {},
          ),
          CheckEditButton(
            text: "Edit Time",
            onPressed: () {},
            enabled: false,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return EditMonthCalendar(
              index: index,
            );
          }),
    );
  }
}
