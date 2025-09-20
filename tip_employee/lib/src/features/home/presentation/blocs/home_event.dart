import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch user profile
class FetchProfile extends HomeEvent {}

/// Fetch transactions (for Home screen, only latest 5 are kept)
class FetchTips extends HomeEvent {}

/// Search transactions by amount
class SearchTips extends HomeEvent {
  final String query;

  const SearchTips(this.query);

  @override
  List<Object?> get props => [query];
}
