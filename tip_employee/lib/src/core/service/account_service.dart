// lib/src/core/service/account_service.dart
import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';


class AccountService {
  final HttpService httpService;

  AccountService({required this.httpService});

  /// GET BANK ACCOUNT
  Future<BankAccountResponse> getBankAccount() async {
    final response = await httpService.get('/api/employee/bank-account');

    if (response.staticCode == 200) {
      return BankAccountResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load bank account: ${response.data}');
    }
  }

  /// UPDATE BANK ACCOUNT
  Future<BankAccountResponse> updateBankAccount(BankAccountRequest request) async {
    final response = await httpService.put(
      '/api/employee/bank-account',
      request.toJson(),
    );

    if (response.staticCode == 200) {
      return BankAccountResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to update bank account: ${response.data}');
    }
  }
}
