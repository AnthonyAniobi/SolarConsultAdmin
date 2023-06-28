import 'package:admin/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:admin/features/calendar/presentation/widgets/month_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Schedule"),
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Delete All Schedule"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("Upload"), Icon(Icons.upload)],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return MonthCalendar(
                        index: index,
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
