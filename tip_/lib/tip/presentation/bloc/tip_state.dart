import '../../data/model/tip_response.dart';

abstract class TipState {}

class TipInitial extends TipState {}

class TipLoading extends TipState {}

class TipSuccess extends TipState {
  final TipResponse response;
  TipSuccess({required this.response});
}

class TipFailure extends TipState {
  final String message;
  TipFailure({required this.message});
}
