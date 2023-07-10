import 'package:admin/core/enums/weekdays.dart';
import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/core/presentation/widgets/custom_alert_dialog.dart';
import 'package:admin/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectBookingDayScreen extends StatelessWidget {
  const SelectBookingDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Days"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            )),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return _MonthCalendar(
              index: index,
            );
          }),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({
    super.key,
    required this.index,
  });
  final int index;

  DateTime get currentMonth =>
      DateUtils.addMonthsToMonthDate(DateTime.now(), index);

  int get getDaysInMonth =>
      DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);

  int get firstWeekdayIndex => DateUtils.firstDayOffset(currentMonth.year,
      currentMonth.month, const DefaultMaterialLocalizations());

  int get numberOfCalendarCell => getDaysInMonth + firstWeekdayIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 2),
              blurRadius: 7,
              color: Colors.black.withOpacity(0.35),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          Text(
            DateFormat("MMMM, yyyy").format(currentMonth).toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Weekdays.values
                .map((e) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          e.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: numberOfCalendarCell,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return firstWeekdayIndex > index
                    ? Container()
                    : _calendarCell(
                        context,
                        DateTime(
                          currentMonth.year,
                          currentMonth.month,
                          (index + 1 - firstWeekdayIndex),
                        ),
                      );
              }),
        ],
      ),
    );
  }

  Widget _calendarCell(BuildContext context, DateTime dateTime) {
    bool canSelect = this.canSelect(context, dateTime);
    return GestureDetector(
      onTap: () {
        if (canSelect) {
          Navigator.pop(context, dateTime);
        } else {
          CustomAlertDialog.basic(
              context, "Consultation is not available today");
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "${dateTime.day}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(canSelect ? 1 : 0.2),
          ),
        ),
      ),
    );
  }

  bool canSelect(BuildContext context, DateTime dateTime) {
    Set<String> dateSet = context.read<CalendarBloc>().state.dateSet;
    if (dateTime.dayIsNotPast && dateSet.contains(dateTime.dayId)) {
      return true;
    } else {
      return false;
    }
  }
}
