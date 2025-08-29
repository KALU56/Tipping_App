import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/routes/route_generator.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/app/themes/themeNotifier.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tip Management',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme, // make sure you define a dark theme
          themeMode: mode,
          initialRoute: AppRoutes.welcome,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}



