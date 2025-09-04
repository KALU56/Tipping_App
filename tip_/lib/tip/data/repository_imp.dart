import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tip_/tip/domain/repository.dart';
import 'model/models.dart';

class TipRepositoryImpl implements TipRepository {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  @override
  Future<bool> checkEmployee(String employeeId) async {
    final url = Uri.parse('$baseUrl/employees-data/employee/$employeeId');

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      // Add your token if required:
      'Authorization': 'Bearer 7|FiKiYeIh0HtO6sgnHyMVYiYIM30ey1JJGs8NmTQmf407f195',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // You can map data to TipModel if needed
      return true; // Employee exists
    } else if (response.statusCode == 404) {
      return false; // Employee not found
    } else {
      throw Exception('Failed to fetch employee data');
    }
  }

  @override
  Future<TipModel> submitTip(String employeeId, double amount) async {
    // For now you can keep your demo submission or call real Tip endpoint
    await Future.delayed(const Duration(seconds: 1));
    return TipModel(employeeId: employeeId, amount: amount, status: 'success');
  }
}
