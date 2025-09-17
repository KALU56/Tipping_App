import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}


class FetchProfile extends HomeEvent {}

class FetchTips extends HomeEvent {}

class SearchTips extends HomeEvent {
  final String query;

  const SearchTips(this.query);

  @override
  List<Object?> get props => [query];
}