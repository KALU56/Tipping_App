abstract class TipEvent {}

class EmployeeIdEntered extends TipEvent {
  final String employeeId;
  EmployeeIdEntered(this.employeeId);
}

class InitializeTipEvent extends TipEvent {
  final String employeeId;
  final String amount;

  InitializeTipEvent({required this.employeeId, required this.amount});
}
