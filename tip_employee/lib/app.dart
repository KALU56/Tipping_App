import 'package:flutter/material.dart';
import 'package:tip_employee/src/features/home/home.dart';
import 'package:tip_employee/src/features/settings/settings.dart';
import 'package:tip_employee/src/features/tip/tip.dart';

import 'package:tip_employee/src/features/home/presentation/widgets/bottom_nav_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 1;

  final List<Widget> _pages = const [
    // TipHistoryScreen(),
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
