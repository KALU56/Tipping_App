import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/tip/domain/transaction_repository.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';


import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final TransactionRepository transactionRepository;

  HomeBloc({
    required this.userRepository,
    required this.transactionRepository,
  }) : super(const HomeState()) {
    on<FetchProfile>(_onFetchProfile);
    on<FetchTips>(_onFetchTips);
    on<SearchTips>(_onSearchTips);
  }

Future<void> _onFetchProfile(FetchProfile event, Emitter<HomeState> emit) async {
  emit(state.copyWith(isLoading: true));
  try {
    final user = await userRepository.getProfile();
    emit(state.copyWith(isLoading: false, user: user, error: null));
  } catch (e) {
    print('Profile fetch error: $e');
    emit(state.copyWith(
      isLoading: false, 
      error: 'Failed to load profile: ${e.toString()}'
    ));
  }
}
     Future<void> _onFetchTips(FetchTips event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final tips = await transactionRepository.getTransactions();

      // Sort descending by createdAt (most recent first)
      tips.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.now();
        final bDate = b.createdAt ?? DateTime.now();
        return bDate.compareTo(aDate);
      });

      // Take top 5 for Home
      final recentTips = tips.length > 5 ? tips.sublist(0, 5) : tips;

      emit(state.copyWith(
        isLoading: false,
        allTips: tips,
        filteredTips: recentTips,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Search by amount
  void _onSearchTips(SearchTips event, Emitter<HomeState> emit) {
    final query = event.query.trim();
    if (query.isEmpty) {
      // Reset to recent tips
      final recentTips =
          state.allTips.length > 5 ? state.allTips.sublist(0, 5) : state.allTips;
      emit(state.copyWith(filteredTips: recentTips));
      return;
    }

    final filtered = state.allTips.where((tip) {
      return tip.amount != null && tip.amount.toString().contains(query);
    }).toList();

    emit(state.copyWith(filteredTips: filtered));
  }
}
