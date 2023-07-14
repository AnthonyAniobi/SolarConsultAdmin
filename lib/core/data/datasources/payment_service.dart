import 'package:admin/core/data/models/app_error.dart';
import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';

class PaymentService {
  static String _publicKey() {
    return "";
  }

  static bool get _isTestMode => AppConfig.isTestMode;

  static double _amount(double price, ExchangeRate rate) => price * rate.rate;

  static String get _redirectUrl => "https://solarconsult.netlify.app/";

  static Customization _customization() => Customization(
        title: 'Pay For Consultation',
        description: 'This money is required to get a physical consultant',
        logo:
            "https://firebasestorage.googleapis.com/v0/b/solar-consult.appspot.com/o/app_logo%2Fic_launcher.png?alt=media&token=0e9f8e32-4247-4093-9038-10bee6baf4e2",
      );

  static Future<void> pay({
    required BuildContext context,
    required double amount,
    required ExchangeRate exchangeRate,
    required String customerEmail,
    required String customerName,
  }) async {
    Customer customer = Customer(
      email: customerEmail,
      name: customerName,
    );

    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: _publicKey(),
      currency: exchangeRate.currency,
      redirectUrl: _redirectUrl,
      txRef: const Uuid().v1(),
      amount: _amount(amount, exchangeRate).toString(),
      customer: customer,
      paymentOptions: "card, payattitude, barter, bank transfer, ussd",
      customization: _customization(),
      isTestMode: _isTestMode,
    );
    final ChargeResponse response = await flutterwave.charge();
    if (response.success ?? false) {
      return;
    } else {
      throw AppError("message failed");
    }
  }
}
