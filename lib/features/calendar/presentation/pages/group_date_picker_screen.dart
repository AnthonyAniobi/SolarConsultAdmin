import 'package:admin/core/enums/weekdays.dart';
import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/core/extensions/string_extension.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupDatePickerScreen extends StatefulWidget {
  const GroupDatePickerScreen({super.key, required this.availableTime});

  final AvailableTime availableTime;

  @override
  State<GroupDatePickerScreen> createState() => _GroupDatePickerScreenState();
}

class _GroupDatePickerScreenState extends State<GroupDatePickerScreen> {
  int monthCount = 3;

  late List<Set<String>> setList;

  @override
  void initState() {
    super.initState();
    setList = List.generate(monthCount, (index) => Set<String>()).toList();
  }

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
        actions: [
          IconButton(
              onPressed: () {
                saveAll();
              },
              icon: const Icon(
                Icons.save,
                color: Colors.green,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return _MonthCalendar(
              index: index,
              daySet: setList[index],
              selectDate: (date) {
                String dayId = date.dayId;
                if (setList[index].contains(dayId)) {
                  setList[index].remove(dayId);
                } else {
                  setList[index].add(dayId);
                }
                setState(() {});
              },
            );
          }),
    );
  }

  void saveAll() {
    List<AvailableTime> avTimes = [];
    for (int i = 0; i < setList.length; i++) {
      Set<String> cSet = setList[i];
      avTimes.addAll(
        cSet.map(
          (dayId) {
            return AvailableTime(
                date: dayId.dayIdToDatetime, hours: widget.availableTime.hours);
          },
        ),
      );
    }
    context.read<CalendarBloc>().add(AddManyAvailableTimeEvent(avTimes));
    Navigator.pop(context);
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({
    super.key,
    required this.index,
    required this.daySet,
    required this.selectDate,
  });
  final int index;
  final Set<String> daySet;
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
                        false,
                      );
              }),
        ],
      ),
    );
  }

  Widget _calendarCell(BuildContext context, DateTime dateTime, bool selected) {
    return GestureDetector(
      onTap: () {
        if (dateTime.dayIsNotPast) {
          selectDate(dateTime);
        }
      },
      child: Container(
        color:
            Colors.green.withOpacity(daySet.contains(dateTime.dayId) ? 0.7 : 0),
        alignment: Alignment.center,
        child: Text(
          "${dateTime.day}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(dateTime.dayIsNotPast ? 1 : 0.2),
          ),
        ),
      ),
    );
  }
}
