// tip_repository_impl.dart
import 'package:tip_/tip/domain/repository.dart';

import 'model/tip_model.dart';


class TipRepositoryImpl implements TipRepository {
  final List<String> _employees = ['EMP001', 'EMP002', 'EMP003'];

  @override
  Future<bool> checkEmployee(String employeeId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _employees.contains(employeeId);
  }

  @override
  Future<TipModel> submitTip(String employeeId, double amount) async {
    await Future.delayed(const Duration(seconds: 1));
    return TipModel(employeeId: employeeId, amount: amount, status: 'success');
  }
}
