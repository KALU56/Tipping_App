import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

// 🔹 Fetch profile data
class FetchProfile extends HomeEvent {}

// 🔹 Fetch recent tips
class FetchRecentTips extends HomeEvent {}

// 🔹 Search tips by customer name
class SearchTips extends HomeEvent {
  final String query;

  const SearchTips(this.query);

  @override
  List<Object?> get props => [query];
}
