import 'package:flutter/material.dart';
import 'screens/employee_selection/employee_selection_screen.dart';

void main() {
  runApp(CustomerPaymentApp());
}

class CustomerPaymentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Payment',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EmployeeSelectionScreen(),
    );
  }
}
