// lib/src/features/transactions/transaction.dart
import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/features/transactions/data/repositories/mock_transaction_repository.dart';
import 'package:tip_employee/src/features/transactions/presentation/components/balance_card.dart';

// Data + Domain
import 'domain/models/transaction_model.dart';
import 'data/mock/mock_transactions.dart';
import 'domain/repositories/transaction_repository.dart';

// Presentation
part 'presentation/screens/transaction_history_screen.dart';
// part 'presentation/components/balance_card.dart';
part 'presentation/components/filter_chips.dart';
// part 'presentation/components/transaction_item.dart';
part 'presentation/components/search_bar.dart';

class TransactionFeature extends StatelessWidget {
  const TransactionFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionHistoryScreen();
  }
}
