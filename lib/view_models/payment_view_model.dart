// import 'package:flutter/material.dart';
// import '../data/repositories/payment_repository.dart';

// class PaymentViewModel extends ChangeNotifier {
//   final PaymentRepository _paymentRepository = PaymentRepository();
//   bool _isProcessing = false;
//   String? _errorMessage;

//   bool get isProcessing => _isProcessing;
//   String? get errorMessage => _errorMessage;

//   // Initialize Stripe Payment
//   void initializePayment() {
//     _paymentRepository.initializePayment();
//   }

//   // Process payment
//   Future<void> processPayment(double amount) async {
//     _isProcessing = true;
//     notifyListeners();

//     try {
//       await _paymentRepository.processPayment(amount);
//       _errorMessage = null;
//     } catch (e) {
//       _errorMessage = e.toString();
//     }

//     _isProcessing = false;
//     notifyListeners();
//   }
// }
