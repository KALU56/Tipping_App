import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/landing_screen.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/login.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/signup.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/welcome.dart';
import 'package:tip_employee/src/features/home/presentation/screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const Welcome());
      case AppRoutes.landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const Signup());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const Home());
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