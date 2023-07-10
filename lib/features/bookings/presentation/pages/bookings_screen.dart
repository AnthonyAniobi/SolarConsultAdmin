import 'package:admin/core/presentation/bloc/bookings/bookings_bloc.dart';
import 'package:admin/features/bookings/presentation/pages/select_booking_day_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                  return ListTile(
                    title: Text(
                        DateFormat('yyyy/MMM/dd  hh:mm').format(booking.date)),
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

  Future<void> addBooking(BuildContext context) async {
    final DateTime? daySelected = await Navigator.of(context).push<DateTime>(
      MaterialPageRoute(
        builder: (context) => const SelectBookingDayScreen(),
      ),
    );
    if (daySelected == null) {
      return;
    }
    // final TimePeriodRange =
  }
}
