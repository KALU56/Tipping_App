
import '../models/tip.dart';

abstract class TipRepository {
  Future<List<Tip>> getRecentTips();
}
