import 'package:tip_employee/src/features/home/domain/models/tip.dart';
import 'package:tip_employee/src/features/home/domain/repositories/tip_repository.dart';

class MockTipRepository implements TipRepository {
  @override
  Future<List<Tip>> getRecentTips() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Tip(customerName: 'Alice', amount: 12.5, minutesAgo: 10),
      Tip(customerName: 'Bob', amount: 8.0, minutesAgo: 45),
    ];
  }

  @override
  Future<List<Tip>> getAllTips() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Tip(customerName: 'Alice', amount: 12.5, minutesAgo: 10),
      Tip(customerName: 'Bob', amount: 8.0, minutesAgo: 45),
      Tip(customerName: 'Charlie', amount: 15.0, minutesAgo: 90),
    ];
  }
}
