abstract class TipEvent {}

class InitializeTipEvent extends TipEvent {
  final String employeeId;
  final String amount;

  InitializeTipEvent({required this.employeeId, required this.amount});
}
