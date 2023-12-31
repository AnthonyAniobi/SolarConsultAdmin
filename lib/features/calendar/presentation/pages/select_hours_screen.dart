import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/domain/entities/selection_hours.dart';
import 'package:admin/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SelectHoursScreen extends StatefulWidget {
  const SelectHoursScreen({super.key, required this.date});

  final DateTime date;

  @override
  State<SelectHoursScreen> createState() => _SelectHoursScreenState();
}

class _SelectHoursScreenState extends State<SelectHoursScreen> {
  List<SelectionHours> hours = [];
  List<int> preSelectedHours = [];
  @override
  void initState() {
    super.initState();
    int numberOfHours = 24;

    if (context
        .read<CalendarBloc>()
        .state
        .dateSet
        .contains(widget.date.dayId)) {
      // if already selecte days here
      AvailableTime avTime = context
          .read<CalendarBloc>()
          .state
          .availableTimes
          .firstWhere((element) => element.date.dayId == widget.date.dayId);
      preSelectedHours = avTime.hours;
    }
    hours = List<SelectionHours>.generate(
      numberOfHours,
      (index) {
        int hourIndex = index;
        bool isSelected = preSelectedHours.contains(hourIndex);
        return SelectionHours(hourIndex, isSelected);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('dd MMMM, yyyy').format(widget.date),
        ),
        actions: [
          IconButton(
            onPressed: saveSchedule,
            icon: const Icon(
              Icons.save,
              color: Colors.green,
            ),
          ),
          IconButton(
              onPressed: deleteSchedule,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: hours.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    final hour = hours[index];
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Checkbox(
                            value: hour.selected, onChanged: (value) {}),
                        onTap: () {
                          setState(() {
                            hours[index].selected = !hours[index].selected;
                          });
                        },
                        title: Text(hour.hour),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void saveSchedule() {
    if (hours.isEmpty) {
      deleteSchedule();
    } else {
      AvailableTime time = AvailableTime(
        date: widget.date,
        hours: hours
            .where((element) => element.selected)
            .map<int>((SelectionHours sHours) => sHours.index)
            .toList(),
      );
      context.read<CalendarBloc>().add(AddAvailableTimeEvent(time));
      Navigator.pop(context);
    }
  }

  void deleteSchedule() {
    hours.map((e) => e.selected = false);
    for (int i = 0; i < hours.length; i++) {
      hours[i].selected = false;
    }
    setState(() {});
    context.read<CalendarBloc>().add(
          RemoveAvailableTimeEvent(widget.date),
        );
  }
}
