import 'package:flutter/material.dart';
import 'package:flutter_stripe_payment_integration/services/payment_services.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = false;
  Future<void> _handleStripePayment() async {
    setState(() {
      isLoading = true;
    });

    final result = await PaymentServices.instance.makePayment(89.98, "usd");

    switch (result) {
      case PaymentStatus.success:
        _showMessage("Payment successful");
        break;
      case PaymentStatus.cancelled:
        _showMessage("Payment cancelled", isError: true);
        break;
      case PaymentStatus.failed:
        _showMessage("Payment failed. Please try again.", isError: true);
        break;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Payment"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isLoading ? null : _handleStripePayment,
              child:
                  isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                        "Pay with Stripe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        // behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
