import 'dart:async';

class ChapaService {
  Future<bool> processPayment(double amount) async {
    // Simulate network call / payment processing
    await Future.delayed(Duration(seconds: 2));
    return true; // Payment success
  }
}
