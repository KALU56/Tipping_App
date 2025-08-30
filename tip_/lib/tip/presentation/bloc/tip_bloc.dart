import 'package:bloc/bloc.dart';

import 'package:tip_/tip/data/repository_imp.dart';
import 'tip_event.dart';
import 'tip_state.dart';


class TipBloc extends Bloc<TipEvent, TipState> {
  final TipRepositoryImpl repository;

  TipBloc(this.repository) : super(TipState()) {
    on<EmployeeIdEntered>(_onEmployeeIdEntered);
    on<TipAmountEntered>(_onTipAmountEntered);
    on<TipSubmitted>(_onTipSubmitted);
  }

  void _onEmployeeIdEntered(EmployeeIdEntered event, Emitter<TipState> emit) async {
    emit(TipState(isSubmitting: true));
    final exists = await repository.checkEmployee(event.employeeId);
    emit(TipState(
      employeeId: event.employeeId,
      employeeExists: exists,
      isSubmitting: false,
    ));
  }

  void _onTipAmountEntered(TipAmountEntered event, Emitter<TipState> emit) {
    emit(TipState(tipAmount: event.amount));
  }

  void _onTipSubmitted(TipSubmitted event, Emitter<TipState> emit) async {
    if (!state.employeeExists) {
      emit(TipState(errorMessage: 'Employee not found'));
      return;
    }
    if (state.tipAmount <= 0) {
      emit(TipState(errorMessage: 'Enter a valid tip amount'));
      return;
    }

    emit(TipState(isSubmitting: true));
    final result = await repository.submitTip(state.employeeId, state.tipAmount);
    emit(TipState(isSuccess: result.status == 'success'));
  }
}
