import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/extensions/exchange_rate_list_extension.dart';
import 'package:admin/core/presentation/bloc/exchange_rates/exchange_rates_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<ExchangeRate?> rateNotifier =
        ValueNotifier<ExchangeRate?>(null);
    if (context.read<ExchangeRatesBloc>().state is ExchangeRatesInitial) {
      context.read<ExchangeRatesBloc>().add(GetExchangeRates());
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
            builder: (context, state) {
              if (state is ExchangeRatesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ExchangeRatesSuccess) {
                rateNotifier.value ??= state.rates.withoutPriceList.first;
                return ValueListenableBuilder(
                  valueListenable: rateNotifier,
                  builder: (context, rate, child) {
                    return Column(
                      children: [
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            const Text("Select Rate: "),
                            DropdownButton<ExchangeRate>(
                              value: rate,
                              items: state.rates.withoutPriceList
                                  .map(
                                    (exchangeRate) =>
                                        DropdownMenuItem<ExchangeRate>(
                                      value: exchangeRate,
                                      child: Text(exchangeRate.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  rateNotifier.value = value;
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: rate!.currency),
                              TextSpan(
                                text: " ${rate.rate * state.rates.priceRate}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, rate);
                          },
                          child: const Text("makePayment"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ExchangeRatesBloc>().add(GetExchangeRates());
                    },
                    child: const Text("Reload"),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
