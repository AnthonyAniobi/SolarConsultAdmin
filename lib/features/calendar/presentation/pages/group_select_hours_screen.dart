import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/domain/entities/selection_hours.dart';
import 'package:flutter/material.dart';

class GroupSelectHoursScreen extends StatefulWidget {
  const GroupSelectHoursScreen({super.key});

  @override
  State<GroupSelectHoursScreen> createState() => _GroupSelectHoursScreenState();
}

class _GroupSelectHoursScreenState extends State<GroupSelectHoursScreen> {
  List<SelectionHours> hours = [];
  @override
  void initState() {
    super.initState();
    int numberOfHours = 24;

    hours = List<SelectionHours>.generate(
      numberOfHours,
      (index) => SelectionHours(index, false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Group Time",
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
    AvailableTime time = AvailableTime(
      date: DateTime.now(),
      hours: hours
          .where((element) => element.selected)
          .map<int>((SelectionHours sHours) => sHours.index)
          .toList(),
    );
    Navigator.pop(context, time);
  }

  void deleteSchedule() {
    hours.map((e) => e.selected = false);
    for (int i = 0; i < hours.length; i++) {
      hours[i].selected = false;
    }
    setState(() {});
  }
}
