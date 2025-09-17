import 'package:equatable/equatable.dart';
import 'package:tip_employee/shared/data/models/tip_model.dart';



abstract class TipState extends Equatable {
  const TipState();

  @override
  List<Object?> get props => [];
}

class TipInitial extends TipState {}

class TipLoading extends TipState {}

class TipLoaded extends TipState {
  final List<Tip> tips;
  const TipLoaded(this.tips);

  @override
  List<Object?> get props => [tips];
}

class TipError extends TipState {
  final String message;
  const TipError(this.message);

  @override
  List<Object?> get props => [message];
}
