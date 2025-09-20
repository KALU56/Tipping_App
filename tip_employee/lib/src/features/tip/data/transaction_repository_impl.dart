import 'package:tip_employee/src/core/service/transaction_service.dart';
import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';
import 'package:tip_employee/src/features/tip/domain/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionService _transactionService;

  TransactionRepositoryImpl(this._transactionService);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    print('🛠 RepoImp: Getting transactions via TransactionService');
    final transactions = await _transactionService.fetchTransactions();
    print('🛠 RepoImp: Fetched ${transactions.length} transactions');
    return transactions;
  }
}
