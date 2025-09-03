// tip_repository.dart
import '../data/model/models.dart';


abstract class TipRepository {
  Future<bool> checkEmployee(String employeeId);
  Future<TipModel> submitTip(String employeeId, double amount);
}
