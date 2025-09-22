import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/http_service/http_service_response_model.dart';
import 'package:tip_employee/src/features/tip/data/models/transaction_model.dart';
class TransactionService {
  final HttpService _httpService;

  TransactionService(this._httpService);

  Future<List<TransactionModel>> fetchTransactions() async {
    const endpoint = '/api/employees/transactions';
    print('🛠 TransactionService: Fetching transactions from $endpoint');

    try {
      final HttpServiceResponseModel response =
          await _httpService.get(endpoint);

      print('🛠 TransactionService: Status code ${response.staticCode}');
      print('🛠 TransactionService: Response data ${response.data}');

      if (response.staticCode == 200) {
        final data = response.data;

        // ✅ fix: API root key is "payments"
        if (data is Map && data['payments'] is List) {
          return (data['payments'] as List)
              .map((json) => TransactionModel.fromJson(json))
              .toList();
        }

        // Fallback if backend ever returns just a list
        if (data is List) {
          return data.map((json) => TransactionModel.fromJson(json)).toList();
        }
      }

      print('⚠️ TransactionService: No transactions found or wrong format');
    } catch (e, stack) {
      print('❌ TransactionService Exception: $e');
      print(stack);
    }

    return [];
  }
}
