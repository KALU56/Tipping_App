// tip_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:tip_/tip/domain/repository.dart';

import 'tip_event.dart';
import 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  final TipRepository repository;

  TipBloc(this.repository) : super(TipState()) {
    on<EmployeeIdEntered>(_onEmployeeIdEntered);
    on<TipAmountEntered>(_onTipAmountEntered);
    on<TipSubmitted>(_onTipSubmitted);
  }

  void _onEmployeeIdEntered(EmployeeIdEntered event, Emitter<TipState> emit) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    final exists = await repository.checkEmployee(event.employeeId);
    emit(state.copyWith(
      isSubmitting: false,
      employeeId: event.employeeId,
      employeeExists: exists,
      errorMessage: exists ? null : 'Employee not found',
    ));
  }

  void _onTipAmountEntered(TipAmountEntered event, Emitter<TipState> emit) {
    emit(state.copyWith(tipAmount: event.amount, errorMessage: null));
  }

  void _onTipSubmitted(TipSubmitted event, Emitter<TipState> emit) async {
    if (!state.employeeExists) {
      emit(state.copyWith(errorMessage: 'Employee not found'));
      return;
    }
    if (state.tipAmount <= 0) {
      emit(state.copyWith(errorMessage: 'Enter a valid tip amount'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    final result = await repository.submitTip(state.employeeId, state.tipAmount);
    emit(state.copyWith(
      isSubmitting: false,
      isSuccess: result.status == 'success',
    ));
  }
}
