// lib/src/domain/repositories/bank_account_repository.dart
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_resolution_response.dart';

abstract class BankAccountRepository {
  /// Fetch existing bank account. Returns null if not found.
  Future<BankAccountResponse?> getBankAccount();

  /// Create or update a bank account
  Future<BankAccountResponse> updateBankAccount(BankAccountRequest request);

  /// Get list of banks
  Future<List<Bank>> getBanks();

  /// Resolve account number with bank code
  Future<BankResolutionResponse> resolveAccount({
    required String accountNumber,
    required String bankCode,
  });

  /// Fetch existing bank account or create if missing
  Future<BankAccountResponse> getOrCreateBankAccount({
    required String businessName,
    required String accountName,
    required String accountNumber,
    required Bank bank,
  });

  /// Validate via resolution and then create or fetch the bank account
  Future<BankAccountResponse> validateAndCreateBankAccount({
    required String businessName,
    required String accountName,
    required String accountNumber,
    required Bank bank,
  });
}
