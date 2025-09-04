// tip_state.dart
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

  TipState copyWith({
    String? employeeId,
    bool? employeeExists,
    double? tipAmount,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return TipState(
      employeeId: employeeId ?? this.employeeId,
      employeeExists: employeeExists ?? this.employeeExists,
      tipAmount: tipAmount ?? this.tipAmount,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}