
import 'package:tip_employee/src/core/service/tip_service.dart';
import 'package:tip_employee/src/shared/data/models/tip.dart';

import '../domain/tip_repository.dart';

class TipRepositoryImpl implements TipRepository {
  final TipService tipService;

  TipRepositoryImpl({required this.tipService});

  @override
  Future<List<TipModel>> fetchEmployeeTips() async {
    try {
      return await tipService.getEmployeeTips();
    } catch (e) {
      throw Exception("Error fetching tips: $e");
    }
  }
}
