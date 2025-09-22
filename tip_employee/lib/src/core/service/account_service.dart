import 'dart:convert';
import 'dart:developer'; // for log()
import 'package:http/http.dart' as http;
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_resolution_response.dart'; // NEW: Add this import
import 'http_service/http_service.dart';

class AccountService {
  final HttpService httpService;
  final String chapaApiKey =
      "CHASECK_TEST-skBas9KQBa87Dbx7OyMpQicnYN0jIowy"; // secure in real app

  AccountService({required this.httpService});

  // Your existing getBanks method (updated to use 'id' instead of 'code')
  Future<List<Bank>> getBanks() async {
    log("🔍 [getBanks] Fetching banks from Chapa API...");

    final headers = {'Authorization': 'Bearer $chapaApiKey'};
    final request = http.Request(
      'GET',
      Uri.parse('https://api.chapa.co/v1/banks'),
    );
    request.headers.addAll(headers);

    final streamedResponse = await request.send();
    log("✅ [getBanks] Response status: ${streamedResponse.statusCode}");

    if (streamedResponse.statusCode == 200) {
      final responseString = await streamedResponse.stream.bytesToString();
      log("📦 [getBanks] Raw response: $responseString");

      final jsonData = json.decode(responseString);
      final List banksJson = jsonData['data'] ?? [];
      log("🏦 [getBanks] Parsed ${banksJson.length} banks");

      // Log first few banks for debugging
      for (int i = 0; i < banksJson.length && i < 3; i++) {
        final bankData = banksJson[i];
        log("🏦 Bank ${i + 1}: ${bankData['name']} (ID: ${bankData['id']})");
      }

      return banksJson.map((e) => Bank.fromJson(e)).toList();
    } else {
      final reason = streamedResponse.reasonPhrase;
      final errorBody = await streamedResponse.stream.bytesToString();
      log("❌ [getBanks] Failed: $reason, Body: $errorBody");
      throw Exception('Failed to fetch banks: $reason');
    }
  }

  // Your existing getBankAccount method (unchanged)
  Future<BankAccountResponse> getBankAccount() async {
    log("🔍 [getBankAccount] Fetching employee bank account...");

    final response = await httpService.get('/api/employee/bank-account');
    log("✅ [getBankAccount] Status: ${response.staticCode}, Data: ${response.data}");

    if (response.staticCode == 200) {
      return BankAccountResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load bank account: ${response.data}');
    }
  }

  // Your existing updateBankAccount method (unchanged)
  Future<BankAccountResponse> updateBankAccount(
      BankAccountRequest request) async {
    log("🔍 [updateBankAccount] Updating bank account with: ${request.toJson()}");

    final response = await httpService.put(
      '/api/employee/bank-account',
      request.toJson(),
    );

    log("✅ [updateBankAccount] Status: ${response.staticCode}, Data: ${response.data}");

    if (response.staticCode == 200) {
      return BankAccountResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to update bank account: ${response.data}');
    }
  }

  // NEW: Account resolution method for auto-detection
  Future<BankResolutionResponse> resolveAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    log("🔍 [resolveAccount] Resolving account: $accountNumber for bank code: $bankCode");

    // Validate inputs
    if (accountNumber.isEmpty) {
      throw Exception('Account number cannot be empty');
    }
    if (bankCode.isEmpty) {
      throw Exception('Bank code cannot be empty');
    }

    final headers = {'Authorization': 'Bearer $chapaApiKey'};
    final url = Uri.parse(
      'https://api.chapa.co/v1/account/resolve?account_number=$accountNumber&bank_code=$bankCode'
    );
    
    final request = http.Request('GET', url);
    request.headers.addAll(headers);

    final streamedResponse = await request.send();
    log("✅ [resolveAccount] Response status: ${streamedResponse.statusCode}");

    if (streamedResponse.statusCode == 200) {
      final responseString = await streamedResponse.stream.bytesToString();
      log("📦 [resolveAccount] Success response: $responseString");

      final jsonData = json.decode(responseString);
      final resolution = BankResolutionResponse.fromJson(jsonData);
      
      log("✅ [resolveAccount] Resolution successful: ${resolution.accountName} @ ${resolution.bankName}");
      return resolution;
    } else {
      // Get error details
      final errorBody = await streamedResponse.stream.bytesToString();
      log("❌ [resolveAccount] Failed with status ${streamedResponse.statusCode}: $errorBody");

      // Handle specific Chapa error codes
      switch (streamedResponse.statusCode) {
        case 400:
          final errorJson = json.decode(errorBody);
          final errorMsg = errorJson['message'] ?? 'Invalid account details';
          throw Exception('Account validation failed: $errorMsg');
        case 404:
          throw Exception('Bank or account not found');
        case 401:
          throw Exception('Invalid API key - please check your Chapa credentials');
        case 429:
          throw Exception('Too many requests - please try again later');
        default:
          throw Exception('Failed to resolve account: ${streamedResponse.reasonPhrase}');
      }
    }
  }
}