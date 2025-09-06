import 'package:equatable/equatable.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/data/models/tip_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final User? user;
  final List<Tip> recentTips;
  final List<Tip> filteredTips;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.user,
    this.recentTips = const [],
    this.filteredTips = const [],
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    User? user,
    List<Tip>? recentTips,
    List<Tip>? filteredTips,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      recentTips: recentTips ?? this.recentTips,
      filteredTips: filteredTips ?? this.filteredTips,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, user, recentTips, filteredTips, error];
}
