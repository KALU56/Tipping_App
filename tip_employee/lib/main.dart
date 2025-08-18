import 'package:flutter/material.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/login.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/signup.dart';
import 'package:tip_employee/src/features/home/presentation/screens/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      initialRoute: '/Signup', // starting screen
      routes: {
        '/Signup': (context) => const Signup(),
        '/Login': (context) => const Login(),
        '/Home': (context) => const Home(), // 👈 must register here
      },
    );
  }
}
