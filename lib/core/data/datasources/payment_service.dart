import 'package:admin/core/data/models/exchange_rates.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';

class PaymentService {
  static String _publicKey() {
    if (_isTestMode) {
      return dotenv.env['PUBLIC_KEY_TEST'] ?? "";
    } else {
      return dotenv.env['PUBLIC_KEY_LIVE'] ?? "";
    }
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

  static Future<bool> pay({
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
      amount: amount.toString(),
      customer: customer,
      paymentOptions: "card, payattitude, barter, bank transfer, ussd",
      customization: _customization(),
      isTestMode: _isTestMode,
    );
    try {
      final ChargeResponse response = await flutterwave.charge();
      if (response.success ?? false) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
