import 'package:flutter/material.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
    home: Welcome(),
    
    );
  }
}