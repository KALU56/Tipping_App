import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> getTransactions();
}
