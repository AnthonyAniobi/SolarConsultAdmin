import 'dart:typed_data';
// ignore: depend_on_referenced_packages
import 'package:admin/core/data/datasources/payment_service.dart';
import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/presentation/bloc/exchange_rates/exchange_rates_bloc.dart';
import 'package:collection/collection.dart';
import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/extensions/booking_extension.dart';
import 'package:admin/core/presentation/bloc/bookings/bookings_bloc.dart';
import 'package:admin/core/data/datasources/image_service.dart';
import 'package:admin/core/data/models/time_period_range.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

class AddBookingsScreen extends StatefulWidget {
  const AddBookingsScreen({
    super.key,
    required this.date,
    required this.timePeriod,
  });
  final DateTime date;
  final TimePeriodRange timePeriod;

  @override
  State<AddBookingsScreen> createState() => _AddBookingsScreenState();
}

class _AddBookingsScreenState extends State<AddBookingsScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
        leading: TextButton(
          child: const Icon(
            Icons.close,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
        title: const Text("Booking Information"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _inputField(firstNameController, "First Name"),
                _inputField(lastNameController, "Last Name"),
                _inputField(emailController, "Email"),
                _inputField(descriptionController, "Description", 4),
                ElevatedButton(
                  onPressed: () async {
                    await getImage();
                  },
                  child: const Text("Add Images"),
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  onPressed: () async {
                    submit(context);
                  },
                  child: const Text("Create booking"),
                ),
                SizedBox(height: 2.h),
                Wrap(
                  spacing: 2.w,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 2.w,
                  children: images
                      .mapIndexed(
                        (index, mImg) => SizedBox(
                          width: 30.w,
                          height: 30.w,
                          child: Stack(
                            children: [
                              Image.memory(
                                mImg,
                                width: 30.w,
                                height: 30.w,
                              ),
                              Container(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: InkWell(
                                  onTap: () {
                                    images.removeAt(index);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final Uint8List? byteImage = await ImageService.pickImage(context);
    if (byteImage != null) {
      setState(() {
        images.add(byteImage);
      });
    }
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

  Future<void> payMethod(BuildContext context) async {
    double amount = context
        .read<ExchangeRatesBloc>()
        .state
        .rates
        .firstWhere((element) => element.currency == ExchangeRate.priceId)
        .rate;
    ExchangeRate exchangeRate =
        context.read<ExchangeRatesBloc>().state.rates.first;
    String name = "${firstNameController.text} ${lastNameController.text}";
    await PaymentService.pay(
        context: context,
        amount: amount,
        exchangeRate: exchangeRate,
        customerEmail: emailController.text,
        customerName: name);
  }

  void submit(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      String uuid = const Uuid().v4();

      Booking newBooking = Booking(
        bookingId: uuid,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        date: widget.date,
        meetingLink: "",
        timeRange: widget.timePeriod,
        userId: FirebaseAuth.instance.currentUser!.uid,
        description: descriptionController.text,
        images: [],
      );
      context.read<BookingsBloc>().add(
            CreateNewBookingEvent(
              newBooking.toUtcTimezone,
              images,
            ),
          );
      Navigator.pop(context);
    }
  }
}
