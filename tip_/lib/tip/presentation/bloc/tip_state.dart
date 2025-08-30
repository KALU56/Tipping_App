class TipState {
  final String employeeId;
  final bool employeeExists;
  final double tipAmount;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  TipState({
    this.employeeId = '',
    this.employeeExists = false,
    this.tipAmount = 0,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });
}
