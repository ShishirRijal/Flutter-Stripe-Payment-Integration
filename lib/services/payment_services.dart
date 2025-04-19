import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

enum PaymentStatus { success, cancelled, failed }

class PaymentServices {
  PaymentServices._();

  static final PaymentServices _instance = PaymentServices._();
  static PaymentServices get instance => _instance;

  Future<PaymentStatus> makePayment(double amount, String currency) async {
    try {
      String? clientPaymentSecret = await _createPaymentIntent(
        amount,
        currency,
      );

      if (clientPaymentSecret == null) {
        return PaymentStatus.failed;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientPaymentSecret,
          merchantDisplayName: 'Flutter Developer',
        ),
      );
      return _processPayment(); // Show the payment sheet
    } catch (e) {
      return PaymentStatus.failed;
    }
  }

  Future<PaymentStatus> _processPayment() async {
    try {
      // Show the payment sheet
      await Stripe.instance.presentPaymentSheet();

      /// NOTE:
      /// Don't use await Stripe.instance.confirmPaymentSheetPayment();
      /// because it will throw an error if the payment is successful.
      ///* The payment sheet will automatically confirm the payment
      ///
      return PaymentStatus.success;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        return PaymentStatus.cancelled;
      } else {
        return PaymentStatus.failed;
      }
    } catch (_) {
      return PaymentStatus.failed;
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    Dio dio = Dio();

    Map<String, dynamic> body = {
      'amount':
          (amount * 100).toInt().toString(), // Stripe requires amount in cents
      'currency': currency,
    };

    try {
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        return response.data['client_secret'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
