import 'package:flutter/material.dart';
import 'package:tip_employee/src/core/service/account_service.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_resolution_response.dart'; // NEW: Add this import
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';

class BankAccountRepositoryImpl implements BankAccountRepository {
  final AccountService accountService;

  BankAccountRepositoryImpl({required this.accountService});

  @override
  Future<BankAccountResponse> getBankAccount() async {
    try {
      return await accountService.getBankAccount();
    } catch (e) {
      // Log the error for debugging
      debugPrint('❌ Repository getBankAccount failed: $e');
      rethrow; // Re-throw to let the caller handle it
    }
  }

  @override
  Future<BankAccountResponse> updateBankAccount(BankAccountRequest request) async {
    try {
      return await accountService.updateBankAccount(request);
    } catch (e) {
      debugPrint('❌ Repository updateBankAccount failed: $e');
      rethrow;
    }
  }

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

  // NEW: Implement the resolveAccount method
  @override
  Future<BankResolutionResponse> resolveAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    try {
      // Input validation at repository level
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

      // Additional validation: check if resolution was successful
      if (!resolution.isValid) {
        debugPrint('⚠️ Repository: Resolution returned but not valid');
        // Don't throw here - let the UI handle "not found" gracefully
      } else {
        debugPrint('✅ Repository: Account resolved successfully - ${resolution.accountName}');
      }

      return resolution;
    } catch (e) {
      debugPrint('❌ Repository resolveAccount failed: $e');
      
      // Wrap service errors with context
      if (e.toString().contains('Invalid account number')) {
        throw Exception('The account number you entered is not valid for this bank');
      } else if (e.toString().contains('Bank not found')) {
        throw Exception('The selected bank is not available');
      }
      
      rethrow; // Re-throw for other errors
    }
  }

  // Optional: Public getter for the underlying service (for advanced use cases)
  // Only use this if you need direct service access in UI components
  AccountService get _service => accountService;
}