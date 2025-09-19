import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository.dart';
import 'tip_event.dart';
import 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  final TipRepository repository;

  TipBloc({required this.repository}) : super(TipInitial()) {
    on<InitializeTipEvent>((event, emit) async {
      emit(TipLoading());

      try {
        final response = await repository.initializeTip(
          employeeId: event.employeeId,
          amount: event.amount,
        );
        emit(TipSuccess(response: response));
      } catch (e) {
        emit(TipFailure(message: e.toString()));
      }
    });
  }
}
