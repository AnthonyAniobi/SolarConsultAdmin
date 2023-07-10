import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:admin/features/calendar/presentation/pages/group_date_picker_screen.dart';
import 'package:admin/features/calendar/presentation/pages/group_select_hours_screen.dart';
import 'package:admin/features/calendar/presentation/pages/select_hours_screen.dart';
import 'package:admin/features/calendar/presentation/widgets/month_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(GetAvailableTimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Schedule"),
      ),
      body: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CalendarLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      deleteAllSchedule();
                    },
                    child: const Text("Delete All Schedule"),
                  ),
                  const Spacer(),
                  if (state.updated)
                    ElevatedButton(
                      onPressed: () {
                        uploadInfo();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text("Upload"), Icon(Icons.upload)],
                      ),
                    ),
                ],
              ),
              TextButton(
                onPressed: () {
                  selectSheduleGroup();
                },
                child: const Text("Select Schedule group"),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return MonthCalendar(
                        index: index,
                        selectDate: (date) async {
                          await selectDate(date);
                        },
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> selectDate(DateTime time) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectHoursScreen(date: time),
      ),
    );
    setState(() {});
  }

  void deleteAllSchedule() {
    context.read<CalendarBloc>().add(
          DeleteAllAvailableTimeEvent(),
        );
  }

  void selectSheduleGroup() async {
    AvailableTime? avTime = await Navigator.push<AvailableTime>(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupSelectHoursScreen(),
      ),
    );

    if (avTime != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupDatePickerScreen(
            availableTime: avTime,
          ),
        ),
      );
    }
  }

  void uploadInfo() {
    context.read<CalendarBloc>().add(UpdateAvailableTimeEvent());
  }
}
