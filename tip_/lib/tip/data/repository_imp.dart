
import 'model/models.dart';

class TipRepositoryImpl {
  // Fake database of employees
  final List<String> _employees = ['EMP001', 'EMP002', 'EMP003'];

  Future<bool> checkEmployee(String employeeId) async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate network
    return _employees.contains(employeeId);
  }

  Future<TipModel> submitTip(String employeeId, double amount) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate payment processing
    return TipModel(
      employeeId: employeeId,
      amount: amount,
      status: 'success',
    );
  }
}
