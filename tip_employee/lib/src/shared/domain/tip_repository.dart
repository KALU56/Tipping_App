
import 'package:tip_employee/src/shared/data/models/tip.dart';

abstract class TipRepository {
  Future<List<TipModel>> fetchEmployeeTips();
}
