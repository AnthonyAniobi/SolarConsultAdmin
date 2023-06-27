import 'dart:typed_data';

import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/presentation/bloc/bookings/bookings_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class AddBookingsScreen extends StatefulWidget {
  const AddBookingsScreen({super.key});

  @override
  State<AddBookingsScreen> createState() => _AddBookingsScreenState();
}

class _AddBookingsScreenState extends State<AddBookingsScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTimeRange? dateTimeRange;
  final List<Uint8List> images = [];

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Booking"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _inputField(firstNameController, "First Name"),
              _inputField(lastNameController, "Last Name"),
              _inputField(emailController, "Email"),
              _inputField(descriptionController, "Description", 4),
              Wrap(
                spacing: 2.w,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        // dateTimeRange = await showDateRangePicker(
                        //   context: context,
                        //   firstDate: DateTime.now().add(
                        //     const Duration(days: 1),
                        //   ),
                        //   lastDate: DateTime.now().add(
                        //     const Duration(days: 5),
                        //   ),
                        // );
                      },
                      child: const Text("Add Start Time")),
                  // ElevatedButton(
                  //     onPressed: () {}, child: const Text("Add Ending Time")),
                  // ElevatedButton(
                  //     onPressed: () {}, child: const Text("Add Images")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _inputField(TextEditingController controller, String hint,
      [int maxlines = 1]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: TextFormField(
        controller: controller,
        maxLines: maxlines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          label: Text(hint),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.w),
          ),
        ),
        validator: (text) =>
            text == null || text.isEmpty ? "$hint must not be empty" : null,
      ),
    );
  }

  void submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      if (dateTimeRange != null) {
        String uuid = const Uuid().v4();

        Booking newBooking = Booking(
          bookingId: uuid,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          startTime: dateTimeRange!.start,
          timezone: DateTime.now().timeZoneOffset,
          endTime: dateTimeRange!.end,
          userId: FirebaseAuth.instance.currentUser!.uid,
          description: descriptionController.text,
          images: images,
        );
        context.read<BookingsBloc>().add(CreateNewBookingEvent(newBooking));
      }
    }
  }
}
