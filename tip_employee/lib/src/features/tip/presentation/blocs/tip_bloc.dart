import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';
import 'package:tip_employee/src/features/tip/domain/transaction_repository.dart';
import 'package:tip_employee/src/features/tip/presentation/blocs/tip_event.dart';
import 'package:tip_employee/src/features/tip/presentation/blocs/tip_state.dart';


class TipHistoryBloc extends Bloc<TipHistoryEvent, TipHistoryState> {
  final TransactionRepository transactionRepository;

  TipHistoryBloc({required this.transactionRepository})
      : super(const TipHistoryState()) {
    on<FetchAllTransactions>(_onFetchAllTransactions);
    on<FilterTransactions>(_onFilterTransactions);
    on<SearchTransactions>(_onSearchTransactions);
  }

  Future<void> _onFetchAllTransactions(
      FetchAllTransactions event, Emitter<TipHistoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final txs = await transactionRepository.getTransactions();

      // Sort descending by date
      txs.sort((a, b) => (b.createdAt ?? DateTime(1970))
          .compareTo(a.createdAt ?? DateTime(1970)));

      emit(state.copyWith(
        isLoading: false,
        allTransactions: txs,
        filteredTransactions: txs,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onFilterTransactions(
      FilterTransactions event, Emitter<TipHistoryState> emit) {
    final now = DateTime.now();
    List<TransactionModel> filtered;

    switch (event.period) {
      case 'today':
        filtered = state.allTransactions.where((tx) {
          final date = tx.createdAt;
          return date != null &&
              date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        }).toList();
        break;
      case 'week':
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filtered = state.allTransactions.where((tx) {
          final date = tx.createdAt;
          return date != null &&
              date.isAfter(startOfWeek) &&
              date.isBefore(now.add(const Duration(days: 1)));
        }).toList();
        break;
      case 'month':
        filtered = state.allTransactions.where((tx) {
          final date = tx.createdAt;
          return date != null &&
              date.year == now.year &&
              date.month == now.month;
        }).toList();
        break;
      case 'all':
      default:
        filtered = List.from(state.allTransactions);
    }

    emit(state.copyWith(filteredTransactions: filtered));
  }

  void _onSearchTransactions(
      SearchTransactions event, Emitter<TipHistoryState> emit) {
    final query = event.query.trim();
    if (query.isEmpty) {
      // Reset to last filtered period
      emit(state.copyWith(filteredTransactions: state.filteredTransactions));
      return;
    }

    final filtered = state.filteredTransactions.where((tx) {
      final amountStr = (tx.amount ?? 0).toString();
      return amountStr.contains(query);
    }).toList();

    emit(state.copyWith(filteredTransactions: filtered));
  }
}
