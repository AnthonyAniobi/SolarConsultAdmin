import 'package:admin/core/presentation/bloc/bookings/bookings_bloc.dart';
import 'package:admin/core/presentation/bloc/exchange_rates/exchange_rates_bloc.dart';
import 'package:admin/features/auth/presentation/pages/login_screen.dart';
import 'package:admin/features/bookings/presentation/pages/bookings_screen.dart';
import 'package:admin/features/calendar/presentation/pages/calendar_screen.dart';
import 'package:admin/features/exchange_rates/presentation/pages/exchange_rate_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingsBloc>().add(GetAllBookingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solar Admin"),
        actions: [
          IconButton(
            onPressed: () async {
              await logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bookings"),
            Expanded(child: BlocBuilder<BookingsBloc, BookingsState>(
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
                          title: Text(DateFormat('yyyy/MMM/dd  hh:mm')
                              .format(booking.date)),
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
            )),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 5.w,
              runSpacing: 2.w,
              children: [
                ElevatedButton(
                    onPressed: () {
                      questions(context);
                    },
                    child: const Text("Questions")),
                OutlinedButton(
                    onPressed: () {
                      calendarSchedule(context);
                    },
                    child: const Text("Calendar Schedule")),
                ElevatedButton(
                    onPressed: () {
                      addBooking(context);
                    },
                    child: const Text("All Bookings")),
                ElevatedButton(
                    onPressed: () {
                      addExchangeRate(context);
                    },
                    child: const Text("Exchange Rate")),
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void questions(BuildContext context) {}
  void addExchangeRate(BuildContext context) {
    if (context.read<ExchangeRatesBloc>().state is ExchangeRatesInitial) {
      context.read<ExchangeRatesBloc>().add(GetExchangeRates());
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExchangeRateScreen(),
      ),
    );
  }

  void calendarSchedule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CalendarScreen(),
      ),
    );
  }

  void addBooking(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingsScreen(),
      ),
    );
  }

  Future logout(BuildContext context) async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }
}
