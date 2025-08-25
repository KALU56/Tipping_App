// lib/src/features/home/data/mock_tip_repository.dart
import '../domain/models/tip.dart';
import '../domain/repositories/tip_repository.dart';

class MockTipRepository implements TipRepository {
  @override
  Future<List<Tip>> getRecentTips() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay
    
    return List.generate(5, (index) {
      return Tip(
        customerName: 'Customer ${index + 1}',
        amount: (index + 1) * 5.0,
        minutesAgo: (index + 1) * 2,
      );
    });
  }
}
