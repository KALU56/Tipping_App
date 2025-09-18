import 'package:flutter/material.dart';
import 'package:tip_employee/src/core/service/account_service.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_resolution_response.dart';
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';

class BankAccountRepositoryImpl implements BankAccountRepository {
  final AccountService accountService;

  BankAccountRepositoryImpl({required this.accountService});

  /// Fetch existing bank account. Returns null if not found.
  @override
  Future<BankAccountResponse?> getBankAccount() async {
    try {
      return await accountService.getBankAccount();
    } catch (e) {
      debugPrint('❌ Repository getBankAccount failed: $e');
      if (e.toString().contains('Bank account not found')) {
        return null; // No account yet
      }
      rethrow;
    }
  }

  /// Create or update bank account
  @override
  Future<BankAccountResponse> updateBankAccount(BankAccountRequest request) async {
    try {
      return await accountService.updateBankAccount(request);
    } catch (e) {
      debugPrint('❌ Repository updateBankAccount failed: $e');
      rethrow;
    }
  }

  /// Get list of banks
  @override
  Future<List<Bank>> getBanks() async {
    try {
      final banks = await accountService.getBanks();
      debugPrint('✅ Repository loaded ${banks.length} banks successfully');
      return banks;
    } catch (e) {
      debugPrint('❌ Repository getBanks failed: $e');
      rethrow;
    }
  }

  /// Resolve account number with bank code
  @override
  Future<BankResolutionResponse> resolveAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      if (accountNumber.trim().isEmpty) {
        throw Exception('Account number cannot be empty');
      }
      if (bankCode.trim().isEmpty) {
        throw Exception('Bank code cannot be empty');
      }

      debugPrint('🔍 Repository resolving account: $accountNumber for bank: $bankCode');
      
      final resolution = await accountService.resolveAccount(
        accountNumber: accountNumber.trim(),
        bankCode: bankCode.trim(),
      );

      if (!resolution.isValid) {
        debugPrint('⚠️ Repository: Resolution returned but not valid');
      } else {
        debugPrint('✅ Repository: Account resolved successfully - ${resolution.accountName}');
      }

      return resolution;
    } catch (e) {
      debugPrint('❌ Repository resolveAccount failed: $e');
      if (e.toString().contains('Invalid account number')) {
        throw Exception('The account number you entered is not valid for this bank');
      } else if (e.toString().contains('Bank not found')) {
        throw Exception('The selected bank is not available');
      }
      rethrow;
    }
  }

  /// Fetch existing bank account or create if missing
  Future<BankAccountResponse> getOrCreateBankAccount({
    required String accountName,
    required String accountNumber,
    required Bank bank,
  }) async {
    final existing = await getBankAccount();
    if (existing != null) return existing;

    debugPrint('⚠️ No bank account found. Creating a new one...');
    final request = bank.toBankAccountRequest(
      accountName: accountName,
      accountNumber: accountNumber,
    );

    final created = await updateBankAccount(request);
    debugPrint('✅ Bank account created successfully: ${created.subAccountId}');
    return created;
  }

  /// Validate the account via resolution and then create or fetch
  Future<BankAccountResponse> validateAndCreateBankAccount({
    required String accountName,
    required String accountNumber,
    required Bank bank,
  }) async {
    final resolution = await resolveAccount(
      accountNumber: accountNumber,
      bankCode: bank.code,
    );

    if (!resolution.isValid) {
      throw Exception('Account number could not be resolved for this bank');
    }

    return await getOrCreateBankAccount(
      accountName: accountName,
      accountNumber: accountNumber,
      bank: bank,
    );
  }
}
