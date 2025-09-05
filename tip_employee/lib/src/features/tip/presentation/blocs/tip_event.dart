import 'package:equatable/equatable.dart';

abstract class TipEvent extends Equatable {
  const TipEvent();

  @override
  List<Object?> get props => [];
}

class LoadTips extends TipEvent {}

class SearchTips extends TipEvent {
  final String query;
  const SearchTips(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterTips extends TipEvent {
  final int filterIndex;
  const FilterTips(this.filterIndex);

  @override
  List<Object?> get props => [filterIndex];
}
