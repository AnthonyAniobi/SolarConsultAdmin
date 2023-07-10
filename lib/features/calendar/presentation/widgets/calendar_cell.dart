import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarCell extends StatelessWidget {
  const CalendarCell({
    super.key,
    required this.date,
    required this.selectDate,
  });

  final DateTime date;
  final Function(DateTime) selectDate;

  bool get isAfter => date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 1),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDay(context);
      },
      child: Container(
        color: Colors.green.withOpacity(isSelected(context) ? 0.7 : 0),
        alignment: Alignment.center,
        child: Text(
          "${date.day}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(isAfter ? 1 : 0.2),
          ),
        ),
      ),
    );
  }

  bool isSelected(BuildContext context) {
    Set<String> dateSet = context.read<CalendarBloc>().state.dateSet;
    return dateSet.contains(date.dayId);
  }

  void selectDay(BuildContext context) {
    selectDate(date);
  }
}
