import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:tip_/app/themes/app_theme.dart';

import 'package:tip_/tip/core/service/http_service/http_service.dart';
import 'package:tip_/tip/core/service/tip_service.dart';
import 'package:tip_/tip/data/repository_imp.dart';
import 'package:tip_/tip/domain/repository.dart';

import 'package:tip_/tip/presentation/bloc/tip_bloc.dart';
import 'package:tip_/tip/presentation/screens/employee_selection_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final httpService = HttpServiceImpl();
  final tipService = TipService(httpService: httpService);
  final TipRepository tipRepository = TipRepositoryImpl(tipService: tipService);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('am')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      child: CustomerPaymentApp(repository: tipRepository),
    ),
  );
}

class CustomerPaymentApp extends StatefulWidget {
  final TipRepository repository;

  const CustomerPaymentApp({super.key, required this.repository});

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
      create: (context) => TipBloc(repository: widget.repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Customer Payment',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: EmployeeSelectionScreen(toggleTheme: _toggleTheme),
      ),
    );
  }
}
