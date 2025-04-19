# Flutter Stripe Payment Integration 💳

<div align="center">
  
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Stripe](https://img.shields.io/badge/Stripe-626CD9?style=for-the-badge&logo=Stripe&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white) 
![Medium Article](https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white)


</div>

## 🚀 Introduction

A clean, elegant implementation of Stripe payment gateway in Flutter. This repository provides a no-nonsense approach to adding secure payment processing to your Flutter applications with a minimal, ready-to-use implementation.

> 📱 **Run on real devices!** For the best experience, test this implementation on physical devices rather than simulators.

## 📋 Prerequisites

- Flutter SDK 3.0+
- Dart 3.0+
- A Stripe account (free to create)
- Basic understanding of Flutter development

## 🛠️ Installation

### 1. Clone the repository

```bash
git clone https://github.com/ShishirRijal/Flutter-Stripe-Payment-Integration.git
cd Flutter-Stripe-Payment-Integration
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up your Stripe keys

Create an `.env` file in the `assets` folder:

```
STRIPE_PUBLISHABLE_KEY=pk_test_your_publishable_key
STRIPE_SECRET_KEY=sk_test_your_secret_key
```

> ⚠️ **Important:** In production, always move your payment intent creation to a secure backend. Never expose your Stripe Secret Key in client-side code.



## 🚀 How It Works

### 1. Initialize Stripe

We initialize Stripe in `main.dart` with your publishable key:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/.env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}
```

### 2. Create Payment Intent

The `PaymentServices` class handles creating a payment intent and processing the payment:

```dart
Future<String?> _createPaymentIntent(double amount, String currency) async {
  // Creates a payment intent with Stripe
  // Returns the client secret needed for payment
}
```

### 3. Show Payment Sheet

When the user taps "Pay with Stripe":

```dart
await Stripe.instance.presentPaymentSheet();
```

This displays a native UI where users can securely enter their payment details.

## 💻 Usage

Add a payment button to your app:

```dart
ElevatedButton(
  onPressed: () async {
    final result = await PaymentServices.instance.makePayment(89.98, "usd");
    
    if (result == PaymentStatus.success) {
      print("Payment successful!");
    }
  },
  child: Text("Pay with Stripe"),
)
```

## 🧪 Testing

Stripe provides test card numbers for development:

| Card Type | Number | CVC | Expiry |
|-----------|--------|-----|--------|
| Visa (Success) | 4242 4242 4242 4242 | Any 3 digits | Any future date |
| Visa (Failure) | 4000 0000 0000 0002 | Any 3 digits | Any future date |
| Mastercard | 5555 5555 5555 4444 | Any 3 digits | Any future date |

For more test cards, check [Stripe's testing documentation](https://stripe.com/docs/testing).

## 📱 Platform-Specific Setup

### Android

1. Set `minSdkVersion` to 21
2. Use `FlutterFragmentActivity` instead of `FlutterActivity`
3. Use AppCompat theme
4. Disable R8 Full Mode

### iOS

1. Set iOS deployment target to 13.0
2. Update Podfile platform to iOS 13

Full details are available in the [Medium article](https://medium.com/@shishirrijal).

## 🔍 Common Issues

- **Payment sheet doesn't appear**: Ensure you're testing on a physical device
- **Android build fails**: Check that you've followed all Android configuration steps
- **Payment always fails**: Verify you're using the correct test card numbers

## 🚀 Production Considerations

Before moving to production:

1. ⚠️ **Move payment intent creation to your backend server**
2. 🔒 Never expose your Stripe secret key in client code
3. 💰 Update your Stripe account to production mode
4. 📝 Implement proper error handling and logging

## 📚 Resources

- [flutter_stripe Package](https://pub.dev/packages/flutter_stripe)
- [Dio Package](https://pub.dev/packages/dio)
- [Stripe Documentation](https://stripe.com/docs)
- [Full Tutorial on Medium](https://medium.com/@shishirrijal)


## 📱 App Screenshots

<div align="center">

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/5bc79fe3-4eb2-43cf-9da9-6442ce87dbc6" width="200"/></td> 
    <td><img src="https://github.com/user-attachments/assets/1d130384-8cc4-40e9-9eca-f1601afe4ffc" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/18131716-19bc-4f03-b2cd-495a44fab19e" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/2687ceb5-9a81-48cd-9532-4da4d7b543ac" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/a3d0647b-1c6b-40fd-97a7-79e9b227060a" width="200"/></td> 
  </tr>
</table>

</div>

## 📃 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
