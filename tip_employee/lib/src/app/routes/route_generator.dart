import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/landing_screen.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/login.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/signup.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/welcome.dart';

import 'package:tip_employee/mainscreen.dart';

import 'package:tip_employee/src/features/settings/settings.dart';

import 'package:tip_employee/src/features/tip/tip.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const Welcome());
      case AppRoutes.landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case AppRoutes.transactions:
        return MaterialPageRoute(builder: (_) => const TransactionHistoryScreen());

        case AppRoutes.settings:
  return MaterialPageRoute(builder: (_) => const Setting());
      case AppRoutes.home:
  return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}