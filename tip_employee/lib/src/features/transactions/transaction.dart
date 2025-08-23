// lib/src/features/transactions/transaction_history.dart
import 'package:flutter/material.dart';
import './data/models/transaction_model.dart';

// import 'package:tip_employee/src/features/transactions/data/models/transaction_model.dart';
part './presentation/screens/transaction_history_screen.dart';
part './presentation/components/balance_card.dart';
part './presentation/components/filter_chips.dart';
part './presentation/components/transaction_item.dart';
part './presentation/components/search_bar.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionState();
}
