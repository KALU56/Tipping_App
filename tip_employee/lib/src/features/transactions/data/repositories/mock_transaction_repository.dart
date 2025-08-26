// lib/src/features/transactions/data/repositories/mock_transaction_repository.dart
import '../../domain/models/transaction_model.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../mock/mock_transactions.dart';

class MockTransactionRepository implements TransactionRepository {
  final List<TransactionModel> _transactions = MockTransactions.items;

  @override
  List<TransactionModel> getTransactions() => _transactions;

  @override
  double getTotalBalance() =>
      getTotalIncome() - getTotalExpenses();

  @override
  double getTotalIncome() =>
      _transactions.where((t) => t.isIncome).fold(0, (sum, t) => sum + t.amount);

  @override
  double getTotalExpenses() =>
      _transactions.where((t) => !t.isIncome).fold(0, (sum, t) => sum + t.amount.abs());
}
