import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tip_/tip/core/service/http_service/http_service.dart';
import 'package:tip_/tip/core/service/tip_service.dart';

import 'tip/data/repository_imp.dart';
import 'tip/domain/repository.dart';
import 'tip/presentation/bloc/tip_bloc.dart';
import 'tip/presentation/screens/employee_selection_screen.dart';
import 'app/themes/app_theme.dart';


void main() async {
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
    setState(() => _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TipBloc(repository: widget.repository),
      child: MaterialApp(
        title: 'Customer Payment',
        debugShowCheckedModeBanner: false,
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
