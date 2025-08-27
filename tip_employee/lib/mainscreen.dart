import 'package:flutter/material.dart';
import 'package:tip_employee/src/features/home/home.dart';
import 'package:tip_employee/src/features/settings/settings.dart';
import 'package:tip_employee/src/features/transactions/transaction.dart';

import 'package:tip_employee/src/features/home/presentation/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = const [
    TransactionHistoryScreen(),
    Home(),
    Setting(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
