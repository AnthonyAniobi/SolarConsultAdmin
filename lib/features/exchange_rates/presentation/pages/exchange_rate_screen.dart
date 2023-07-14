import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/presentation/bloc/exchange_rates/exchange_rates_bloc.dart';
import 'package:admin/features/exchange_rates/presentation/pages/add_edit_exchange_screen.dart';
import 'package:admin/features/exchange_rates/presentation/pages/exchange_rate_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExchangeRateScreen extends StatelessWidget {
  const ExchangeRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditExchangeScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
        builder: (context, state) {
          if (state is ExchangeRatesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: state.rates.length,
              itemBuilder: (context, index) {
                ExchangeRate rate = state.rates[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.w,
                  ),
                  child: ListTile(
                    title: Text(rate.currency),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExchangeRateDetailScreen(rate: rate),
                        ),
                      );
                    },
                    trailing: rate.isPrice
                        ? null
                        : IconButton(
                            onPressed: () {
                              context.read<ExchangeRatesBloc>().add(
                                    DeleteExchangeRates(rate),
                                  );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                  ),
                );
              });
        },
      ),
    );
  }
}
