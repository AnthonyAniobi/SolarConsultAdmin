import 'package:admin/core/enums/weekdays.dart';
import 'package:admin/features/calendar/presentation/widgets/calendar_cell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required this.index,
    required this.selectDate,
  });
  final int index;
  final Function(DateTime) selectDate;

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
              offset: const Offset(1, 2),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.2),
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
                            fontSize: 15.sp,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
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
                    : CalendarCell(
                        date: DateTime(
                          currentMonth.year,
                          currentMonth.month,
                          (index + 1 - firstWeekdayIndex),
                        ),
                        selectDate: selectDate,
                      );
              }),
        ],
      ),
    );
  }
}
