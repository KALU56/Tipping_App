// lib/src/core/service/account_service.dart
import 'dart:convert';
import 'dart:developer'; // for log()
import 'package:http/http.dart' as http;
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';

import 'http_service/http_service.dart';

class AccountService {
  final HttpService httpService;
  final String chapaApiKey =
      'CHASECK_TEST-HjvGXcCsyxMZW22QMXsG7LD8hbkfx1WI'; // secure in real app

  AccountService({required this.httpService});

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

      return banksJson.map((e) => Bank.fromJson(e)).toList();
    } else {
      final reason = streamedResponse.reasonPhrase;
      log("❌ [getBanks] Failed: $reason");
      throw Exception('Failed to fetch banks: $reason');
    }
  }

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
}
