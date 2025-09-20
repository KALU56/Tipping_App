import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/http_service/http_service_response_model.dart';
import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';
import 'package:tip_employee/src/features/tip/domain/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final HttpService _httpService;

  TransactionRepositoryImpl(this._httpService);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final HttpServiceResponseModel response =
        await _httpService.get('/employees/transactions');

    if (response.staticCode == 200) {
      final data = response.data;

      // Case 1: API returns { "transactions": [ ... ] }
      if (data is Map && data['transactions'] is List) {
        return (data['transactions'] as List)
            .map((json) => TransactionModel.fromJson(json))
            .toList();
      }

      // Case 2: API returns a raw list [ ... ]
      if (data is List) {
        return data.map((json) => TransactionModel.fromJson(json)).toList();
      }
    }

    // If error, return empty list (or throw exception depending on strategy)
    return [];
  }
}
