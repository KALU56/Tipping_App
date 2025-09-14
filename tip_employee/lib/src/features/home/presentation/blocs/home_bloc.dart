import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
import 'package:tip_employee/src/shared/domain/repositories/tip_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final TipRepository tipRepository;

  HomeBloc({
    required this.userRepository,
    required this.tipRepository,
  }) : super(const HomeState()) {
    on<FetchProfile>(_onFetchProfile);
    on<FetchRecentTips>(_onFetchRecentTips);
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
  Future<void> _onFetchRecentTips(
      FetchRecentTips event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final tips = await tipRepository.getRecentTips();
      emit(state.copyWith(isLoading: false, recentTips: tips, filteredTips: tips));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onSearchTips(SearchTips event, Emitter<HomeState> emit) {
    final query = event.query.toLowerCase();
    final filtered = state.recentTips.where((tip) {
      return tip.customerName.toLowerCase().contains(query);
    }).toList();
    emit(state.copyWith(filteredTips: filtered));
  }
}
