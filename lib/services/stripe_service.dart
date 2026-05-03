import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';

class StripeService {
  static const String _publishableKey = 'pk_test_51...'; // Replace with your Stripe test key
  static const String _merchantName = 'ElectroMart Pro';

  /// Initialize Stripe with publishable key.
  static Future<void> init() async {
    Stripe.publishableKey = _publishableKey;
    await Stripe.instance.applySettings();
  }

  /// Simulate creating a PaymentIntent on your backend.
  /// In production, call your backend API to create the intent.
  static Future<String> createPaymentIntent(double amount, String currency) async {
    // Mock payment intent creation
    // In a real app, you would call your backend:
    // final response = await http.post(
    //   Uri.parse('https://your-backend.com/create-payment-intent'),
    //   body: {'amount': (amount * 100).toString(), 'currency': currency},
    // );
    // return response.body; // clientSecret

    // For demo, return a mock client secret
    return 'pi_mock_${DateTime.now().millisecondsSinceEpoch}_secret_mock';
  }

  /// Present the Stripe payment sheet.
  static Future<bool> makePayment(double amount, String currency) async {
    try {
      // Create payment intent (mocked)
      final clientSecret = await createPaymentIntent(amount, currency);

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: _merchantName,
          style: ThemeMode.dark,
        ),
      );

      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      return true; // Payment successful
    } on StripeException catch (e) {
      debugPrint('Stripe error: ${e.error.localizedMessage}');
      return false;
    } catch (e) {
      debugPrint('Payment error: $e');
      return false;
    }
  }
}
