import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // This import will now work
import 'package:easy_localization/easy_localization.dart';

import 'package:tip_/app/themes/app_theme.dart';


import 'package:tip_/tip/data/repository_imp.dart';
import 'package:tip_/tip/domain/repository.dart';
import 'package:tip_/tip/presentation/bloc/tip_bloc.dart';
import 'package:tip_/tip/presentation/screens/employee_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('am')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
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
    return BlocProvider(
      create: (context) => TipBloc(TipRepositoryImpl() as TipRepository),
      child: MaterialApp(
        title: 'Customer Payment',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: EmployeeSelectionScreen(toggleTheme: _toggleTheme),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}