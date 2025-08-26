// lib/src/features/transactions/domain/repositories/transaction_repository.dart
import '../models/transaction_model.dart';

abstract class TransactionRepository {
  List<TransactionModel> getTransactions();
  double getTotalBalance();
  double getTotalIncome();
  double getTotalExpenses();
}
