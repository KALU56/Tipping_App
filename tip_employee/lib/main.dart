import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/routes/route_generator.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/app/themes/themeNotifier.dart';

// Import the abstract repo and its implementation
import 'package:tip_employee/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:tip_employee/src/features/auth/data/repositories/auth_repository_impl.dart';

// Import your bloc
import 'package:tip_employee/src/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_bloc.dart';
import 'package:tip_employee/src/shared/data/mock_user_repository.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  final authRepository = AuthRepositoryImpl();
  final userRepository = MockUserRepository(); // ✅ your user repo

  runApp(MyApp(authRepository: authRepository, userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  const MyApp({super.key, required this.authRepository, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<SettingBloc>(
          create: (_) => SettingBloc(userRepository),
        ),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, mode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tip Management',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            initialRoute: AppRoutes.welcome,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
