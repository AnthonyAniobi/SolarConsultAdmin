import 'package:flutter/material.dart';

class EditCalendarCell extends StatelessWidget {
  const EditCalendarCell({
    super.key,
    required this.date,
  });

  final DateTime date;

  bool get isAfter => date.isAfter(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDay(context);
      },
      child: Container(
        color: Colors.green.withOpacity(isAfter ? 0.5 : 0),
        alignment: Alignment.center,
        child: Text(
          "${date.day}",
          style: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(isAfter ? 1 : 0.2),
          ),
        ),
      ),
    );
  }

  void selectDay(BuildContext context) {
    if (!isAfter) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Cant Select",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                content: Text(
                  "Can't select this day because the day is already gone",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ));
    } else {
      final now = DateTime.now().timeZoneOffset;
      print(now);
    }
  }
}
