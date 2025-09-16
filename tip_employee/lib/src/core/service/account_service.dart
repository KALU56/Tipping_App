import 'package:tip_employee/src/core/service/http_service/http_service.dart';

class AccountService {
  final HttpService httpService;

  AccountService({required this.httpService});

  /// -----------------------------
  /// GET MY TIP ACCOUNT
  /// -----------------------------
  Future<Map<String, dynamic>> getMyAccount() async {
    final response = await httpService.get('/api/employee/account');
    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('❌ Failed to load account info: ${response.data}');
    }
  }

  /// -----------------------------
  /// UPDATE TIP ACCOUNT
  /// -----------------------------
  /// Update both account number and friendly account name
  Future<Map<String, dynamic>> updateAccount({
    required String accountNumber,
    required String accountName,
  }) async {
    final body = {
      'account_number': accountNumber,
      'account_name': accountName,
    };

    final response = await httpService.put('/api/employee/account', body);

    if (response.staticCode == 200) {
      return response.data['data'];
    } else {
      throw Exception('❌ Failed to update account: ${response.data}');
    }
  }
}
