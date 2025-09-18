// lib/src/domain/repositories/bank_account_repository.dart
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_resolution_response.dart';



abstract class BankAccountRepository {
  Future<BankAccountResponse> getBankAccount();
  Future<BankAccountResponse> updateBankAccount(BankAccountRequest request);
    Future<List<Bank>> getBanks();
    Future<BankResolutionResponse> resolveAccount({
    required String accountNumber,
    required String bankCode,
  });
}
