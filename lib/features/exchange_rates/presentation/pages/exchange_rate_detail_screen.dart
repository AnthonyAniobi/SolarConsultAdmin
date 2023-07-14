import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/features/exchange_rates/presentation/pages/add_edit_exchange_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExchangeRateDetailScreen extends StatelessWidget {
  const ExchangeRateDetailScreen({super.key, required this.rate});

  final ExchangeRate rate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rate.currency),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditExchangeScreen(
                    rate: rate,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Text(
                "Rate:",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                rate.rate.toString(),
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    "Active:",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "  ${rate.active.toString().toUpperCase()}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: rate.active ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
