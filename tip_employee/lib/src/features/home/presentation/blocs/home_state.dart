import 'package:equatable/equatable.dart';
import 'package:tip_employee/src/shared/data/models/tip.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';


class HomeState extends Equatable {
  final bool isLoading;
  final User? user;
  final List<TipModel> allTips;
  final List<TipModel> filteredTips;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.user,
     this.allTips = const [],
    this.filteredTips = const [],
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    User? user,
    List<TipModel>? allTips,
    List<TipModel>? filteredTips,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      allTips: allTips ?? this.allTips,
      filteredTips: filteredTips ?? this.filteredTips,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, user, allTips, filteredTips, error];
}
