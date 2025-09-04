// tip_event.dart
abstract class TipEvent {}

class EmployeeIdEntered extends TipEvent {
  final String employeeId;
  EmployeeIdEntered(this.employeeId);
}

class TipAmountEntered extends TipEvent {
  final double amount;
  TipAmountEntered(this.amount);
}

class TipSubmitted extends TipEvent {}