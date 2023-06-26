import 'package:admin/features/auth/presentation/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            Expanded(child: Container()),
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
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void questions(BuildContext context) {}
  void calendarSchedule(BuildContext context) {}
  void addBooking(BuildContext context) {}

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
