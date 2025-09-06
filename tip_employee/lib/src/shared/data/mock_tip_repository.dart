import 'package:flutter/material.dart';
import 'package:tip_employee/src/shared/data/models/tip_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/tip_repository.dart';

class MockTipRepository implements TipRepository {
  @override
  Future<List<Tip>> getRecentTips() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Tip(customerName: 'Alice', amount: 12.5, time: TimeOfDay(hour: 10, minute: 0), date: DateTime.now()),
      Tip(customerName: 'Bob', amount: 8.0, time: TimeOfDay(hour: 11, minute: 45), date: DateTime.now()),
    ];
  }

  @override
  Future<List<Tip>> getAllTips() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Tip(customerName: 'Alice', amount: 12.5, time: TimeOfDay(hour: 10, minute: 0), date: DateTime.now()),
      Tip(customerName: 'Bob', amount: 8.0, time: TimeOfDay(hour: 11, minute: 45), date: DateTime.now()),
      Tip(customerName: 'Charlie', amount: 15.0, time: TimeOfDay(hour: 12, minute: 30), date: DateTime.now()),
      Tip(customerName: 'Alice', amount: 12.5, time: TimeOfDay(hour: 10, minute: 0), date: DateTime.now()),
      Tip(customerName: 'Bob', amount: 8.0, time: TimeOfDay(hour: 11, minute: 45), date: DateTime.now()),
      Tip(customerName: 'Charlie', amount: 15.0, time: TimeOfDay(hour: 12, minute: 30), date: DateTime.now()),
    ];
  }
}
