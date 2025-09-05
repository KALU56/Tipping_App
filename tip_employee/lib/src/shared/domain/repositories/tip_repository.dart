

import 'package:tip_employee/src/shared/data/models/tip_model.dart';

abstract class TipRepository {
  Future<List<Tip>> getRecentTips();
  Future<List<Tip>> getAllTips(); // for transaction screen
  
}
