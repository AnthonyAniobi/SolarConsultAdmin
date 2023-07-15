// ignore_for_file: use_build_context_synchronously

import 'package:admin/core/data/models/booking.dart';
import 'package:admin/core/data/models/time_period_range.dart';
import 'package:admin/core/extensions/datetime_extension.dart';
import 'package:admin/core/presentation/bloc/bookings/bookings_bloc.dart';
import 'package:admin/features/bookings/presentation/pages/add_bookings_screen.dart';
import 'package:admin/features/bookings/presentation/pages/bookings_detail_screen.dart';
import 'package:admin/features/bookings/presentation/pages/select_booking_day_screen.dart';
import 'package:admin/features/bookings/presentation/pages/select_booking_hour_screen.dart';
import 'package:admin/features/calendar/data/models/available_time.dart';
import 'package:admin/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addBooking(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<BookingsBloc, BookingsState>(
        builder: (context, state) {
          if (state is BookingsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BookingsSuccess) {
            if (state.bookings.isEmpty) {
              return const Center(
                child: Text("There is no booking"),
              );
            }
            return ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 1.5.w,
                    ),
                    child: ListTile(
                      onTap: () {
                        bookingDetail(context, booking);
                      },
                      title: Text(
                          "${DateFormat('yyyy/MMM/dd').format(booking.date)} -- ${booking.timeRange}"),
                      subtitle: Text(
                        booking.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            context
                                .read<BookingsBloc>()
                                .add(DeleteBookingEvent(booking));
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("Something went wrong!!"),
            );
          }
        },
      ),
    );
  }

  void bookingDetail(BuildContext context, Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailScreen(booking: booking),
      ),
    );
  }

  Future<void> addBooking(BuildContext context) async {
    if (context.read<CalendarBloc>().state is CalendarInitial) {
      context.read<CalendarBloc>().add(GetAvailableTimeEvent());
    }
    final DateTime? daySelected = await Navigator.of(context).push<DateTime>(
      MaterialPageRoute(
        builder: (context) => const SelectBookingDayScreen(),
      ),
    );
    if (daySelected == null) {
      return;
    }

    final AvailableTime availableTime = context
        .read<CalendarBloc>()
        .state
        .availableTimes
        .firstWhere((avTime) => avTime.date.dayId == daySelected.dayId);

    final List<Booking> bookings = context
        .read<BookingsBloc>()
        .state
        .bookings
        .where((bk) => bk.date.dayId == daySelected.dayId)
        .toList();

    final TimePeriodRange? timePeriodRange =
        await Navigator.push<TimePeriodRange>(
      context,
      MaterialPageRoute(
        builder: (context) => SelectBookingHourScreen(
          availableTime: availableTime,
          bookingRange: bookings,
        ),
      ),
    );

    if (timePeriodRange == null) {
      return;
    }
    Booking? booking = await Navigator.push<Booking>(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookingsScreen(
          date: daySelected,
          timePeriod: timePeriodRange,
        ),
      ),
    );
    if (booking == null) {
      return;
    }
  }
}
