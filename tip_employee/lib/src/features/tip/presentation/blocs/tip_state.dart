import 'package:equatable/equatable.dart';
import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';

class TipHistoryState extends Equatable {
  final bool isLoading;
  final List<TransactionModel> allTransactions;      // all fetched
  final List<TransactionModel> filteredTransactions; // filtered by period or search
  final String? error;

  const TipHistoryState({
    this.isLoading = false,
    this.allTransactions = const [],
    this.filteredTransactions = const [],
    this.error,
  });

  TipHistoryState copyWith({
    bool? isLoading,
    List<TransactionModel>? allTransactions,
    List<TransactionModel>? filteredTransactions,
    String? error,
  }) {
    return TipHistoryState(
      isLoading: isLoading ?? this.isLoading,
      allTransactions: allTransactions ?? this.allTransactions,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, allTransactions, filteredTransactions, error];
}
