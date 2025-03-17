// import 'package:stripe_payment/stripe_payment.dart';

// class PaymentRepository {
//   void initializePayment() {
//     StripePayment.setOptions(
//       StripeOptions(publishableKey: "YOUR_STRIPE_PUBLISHABLE_KEY"),
//     );
//   }

//   Future<void> processPayment(double amount) async {
//     try {
//       await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
//     } catch (e) {
//       throw Exception("Payment failed: ${e.toString()}");
//     }
//   }
// }
