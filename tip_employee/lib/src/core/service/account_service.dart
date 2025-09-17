// lib/src/core/service/account_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';

import 'http_service/http_service.dart';

class AccountService {
  final HttpService httpService;
  final String chapaApiKey = 'CHAPUBK_TEST-VjWm6wfJ6bUEaUXcr9SnCBBEibGjmAl8'; // secure in real app

  AccountService({required this.httpService});

  /// -----------------------------
  /// FETCH BANKS FROM CHAPA
  /// -----------------------------
  Future<List<Bank>> fetchBanks() async {
    final headers = {'Authorization': 'Bearer $chapaApiKey'};
    final request = http.Request(
      'GET',
      Uri.parse('https://api.chapa.co/v1/banks'),
    );
    request.headers.addAll(headers);

    final streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      final responseString = await streamedResponse.stream.bytesToString();
      final jsonData = json.decode(responseString);
      final List banksJson = jsonData['data'] ?? [];
      return banksJson.map((e) => Bank.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch banks: ${streamedResponse.reasonPhrase}');
    }
  }
  Future<List<Bank>> getBanks() async {
    final response = await httpService.get('/api/banks'); // your endpoint

    if (response.staticCode == 200) {
      final banksData = response.data['data'] as List;
      return banksData.map((e) => Bank.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch banks: ${response.data}');
    }
  }
  /// -----------------------------
  /// GET CURRENT BANK ACCOUNT
  /// -----------------------------
  Future<BankAccountResponse> getBankAccount() async {
    final response = await httpService.get('/api/employee/bank-account');

    if (response.staticCode == 200) {
      return BankAccountResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load bank account: ${response.data}');
    }
  }

  /// -----------------------------
  /// UPDATE BANK ACCOUNT
  /// -----------------------------
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
