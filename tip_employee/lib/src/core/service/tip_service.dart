import 'package:tip_employee/src/core/service/http_service/http_service.dart';

import 'package:tip_employee/src/shared/data/models/tip.dart';

class TipService {
  final HttpService httpService;

  TipService({required this.httpService});

  /// -----------------------------
  /// GET TIP HISTORY FOR EMPLOYEE
  /// -----------------------------
  Future<List<TipModel>> getEmployeeTips() async {
    final response = await httpService.get('/api/employees/tips');

    if (response.staticCode == 200) {
      final List tipsData = response.data['tips'] ?? [];
      return tipsData.map((e) => TipModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tips: ${response.data}');
    }
  }
}
