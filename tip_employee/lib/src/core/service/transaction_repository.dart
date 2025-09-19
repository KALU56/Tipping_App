import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/http_service/http_service_response_model.dart';
import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';


class TransactionRepository {
  final HttpService _httpService;

  TransactionRepository(this._httpService);

  Future<List<TransactionModel>> getTransactions() async {
    final HttpServiceResponseModel response =
        await _httpService.get('/employees/transactions');

    if (response.staticCode == 200) {
      final data = response.data;

      if (data is Map && data['transactions'] is List) {
        return (data['transactions'] as List)
            .map((json) => TransactionModel.fromJson(json))
            .toList();
      }

      if (data is List) {
        return data.map((json) => TransactionModel.fromJson(json)).toList();
      }
    }

    // If error, return empty list (or throw an exception if you prefer)
    return [];
  }
}
