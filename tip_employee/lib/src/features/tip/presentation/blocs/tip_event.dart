import 'package:equatable/equatable.dart';

abstract class TipHistoryEvent extends Equatable {
  const TipHistoryEvent();

  @override
  List<Object?> get props => [];
}

// Fetch all transactions
class FetchAllTransactions extends TipHistoryEvent {}

// Filter transactions by period: all, month, week, today
class FilterTransactions extends TipHistoryEvent {
  final String period; // 'all', 'month', 'week', 'today'

  const FilterTransactions(this.period);

  @override
  List<Object?> get props => [period];
}

// Search transactions by amount
class SearchTransactions extends TipHistoryEvent {
  final String query;

  const SearchTransactions(this.query);

  @override
  List<Object?> get props => [query];
}
