// lib/src/features/home/domain/repositories/tip_repository.dart
import '../models/tip.dart';

abstract class TipRepository {
  Future<List<Tip>> getRecentTips();
}
