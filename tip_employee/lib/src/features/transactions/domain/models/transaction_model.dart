// lib/src/features/transactions/domain/models/transaction_model.dart
import 'package:flutter/material.dart';

class TransactionModel {
  final String title;
  final double amount;
  final String date;
  final IconData icon;
  final Color color;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
    required this.color,
  });

  bool get isIncome => amount >= 0;
}
