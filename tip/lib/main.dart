import 'package:flutter/material.dart';
import 'package:tip/app/themes/app_theme.dart';
import 'screens/employee_selection/employee_selection_screen.dart';


void main() {
  runApp(const CustomerPaymentApp());
}

class CustomerPaymentApp extends StatelessWidget {
  const CustomerPaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Payment',
      theme: AppTheme.lightTheme,   // ✅ Light theme
      darkTheme: AppTheme.darkTheme, // ✅ Dark theme
      themeMode: ThemeMode.system,   // ✅ Auto switch based on system
      home: EmployeeSelectionScreen(),
      debugShowCheckedModeBanner: false, // optional, removes debug banner
    );
  }
}
