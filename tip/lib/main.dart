import 'package:flutter/material.dart';
import 'package:tip/app/themes/app_theme.dart';
import 'package:tip/features/givetip/presentation/screens/employee_selection_screen.dart';


void main() {
  runApp(const CustomerPaymentApp());
}

class CustomerPaymentApp extends StatefulWidget {
  const CustomerPaymentApp({super.key});

  @override
  State<CustomerPaymentApp> createState() => _CustomerPaymentAppState();
}

class _CustomerPaymentAppState extends State<CustomerPaymentApp> {
  ThemeMode _themeMode = ThemeMode.light; // default light mode

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Payment',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode, // dynamically changes theme
      home: EmployeeSelectionScreen(toggleTheme: _toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}
