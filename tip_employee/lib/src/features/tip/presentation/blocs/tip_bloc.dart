import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/shared/data/models/tip_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/tip_repository.dart';
import 'tip_event.dart';
import 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  final TipRepository repository;
  List<Tip> _allTips = [];

  TipBloc(this.repository) : super(TipInitial()) {
    on<LoadTips>(_onLoadTips);
    on<SearchTips>(_onSearchTips);
    on<FilterTips>(_onFilterTips);
  }

  Future<void> _onLoadTips(LoadTips event, Emitter<TipState> emit) async {
    emit(TipLoading());
    try {
      _allTips = await repository.getAllTips();
      emit(TipLoaded(_allTips));
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  void _onSearchTips(SearchTips event, Emitter<TipState> emit) {
    final query = event.query.toLowerCase();
    final filtered = _allTips
        .where((tip) => tip.customerName.toLowerCase().contains(query))
        .toList();
    emit(TipLoaded(filtered));
  }

  void _onFilterTips(FilterTips event, Emitter<TipState> emit) {
    final now = DateTime.now();
    List<Tip> filtered;

    switch (event.filterIndex) {
      case 0: // today
        filtered = _allTips
            .where((tip) =>
                tip.date.year == now.year &&
                tip.date.month == now.month &&
                tip.date.day == now.day)
            .toList();
        break;
      case 1: // this week
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        filtered = _allTips
            .where((tip) =>
                tip.date.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
                tip.date.isBefore(weekEnd.add(const Duration(days: 1))))
            .toList();
        break;
      case 2: // this month
        filtered = _allTips
            .where((tip) =>
                tip.date.year == now.year && tip.date.month == now.month)
            .toList();
        break;
      default: // all
        filtered = List.from(_allTips);
    }

    emit(TipLoaded(filtered));
  }
}
