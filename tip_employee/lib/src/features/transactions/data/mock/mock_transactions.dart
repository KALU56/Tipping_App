// lib/src/features/transactions/data/mock/mock_transactions.dart
import 'package:flutter/material.dart';
import '../../domain/models/transaction_model.dart';

class MockTransactions {
  static final List<TransactionModel> items = [
    TransactionModel(
      title: 'CBE',
      amount: -85.30,
      date: 'Today, 10:30 AM',
      icon: Icons.account_balance,
      color: Colors.red,
    ),
    TransactionModel(
      title: 'Telebirr',
      amount: 2500.00,
      date: 'Today, 9:15 AM',
      icon: Icons.phone_android,
      color: Colors.green,
    ),
    TransactionModel(
      title: 'Uber Ride',
      amount: -120.50,
      date: 'Yesterday, 8:20 PM',
      icon: Icons.directions_car,
      color: Colors.orange,
    ),
  ];
}
