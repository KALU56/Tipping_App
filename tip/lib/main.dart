import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tip/features/givetip/presentation/screens/employee_selection_screen.dart';
import 'package:tip/app/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('am')],
      path: 'assets/langs',
      fallbackLocale: Locale('en'),
      child: const CustomerPaymentApp(),
    ),
  );
}

class CustomerPaymentApp extends StatefulWidget {
  const CustomerPaymentApp({super.key});

  @override
  State<CustomerPaymentApp> createState() => _CustomerPaymentAppState();
}

class _CustomerPaymentAppState extends State<CustomerPaymentApp> {
  ThemeMode _themeMode = ThemeMode.light;

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
      themeMode: _themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: EmployeeSelectionScreen(toggleTheme: _toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}
