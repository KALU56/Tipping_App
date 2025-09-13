import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/routes/route_generator.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/app/themes/themeNotifier.dart';
import 'package:tip_employee/src/core/service/auth_service.dart';
import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/user_service.dart';

// Auth
import 'package:tip_employee/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:tip_employee/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tip_employee/src/features/auth/presentation/blocs/auth_bloc.dart';

// Home
import 'package:tip_employee/src/features/home/presentation/blocs/home_bloc.dart';
import 'package:tip_employee/src/features/home/presentation/blocs/home_event.dart';

// Settings
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_bloc.dart';

// Tip
import 'package:tip_employee/src/features/tip/presentation/blocs/tip_bloc.dart';
import 'package:tip_employee/src/features/tip/presentation/blocs/tip_event.dart';
import 'package:tip_employee/src/shared/data/UserRepositoryImpl.dart';

// Shared repos
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
import 'package:tip_employee/src/shared/domain/repositories/tip_repository.dart';
import 'package:tip_employee/src/shared/data/mock_tip_repository.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // 1️⃣ Core services
  final httpService = HttpServiceImpl();
  final authService = AuthService(httpService);

  // 2️⃣ Repositories
  final authRepository = AuthRepositoryImpl(authService);
  final userService = UserService(httpService);
  final userRepository = UserRepositoryImpl(userService: userService);
  final tipRepository = MockTipRepository(); // you can later replace with real TipRepositoryImpl

  runApp(MyApp(
    authRepository: authRepository,
    userRepository: userRepository,
    tipRepository: tipRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final TipRepository tipRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.userRepository,
    required this.tipRepository,
  });

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
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(
            userRepository: userRepository,
            tipRepository: tipRepository,
          )
            ..add(FetchProfile())
            ..add(FetchRecentTips()),
        ),
        BlocProvider<TipBloc>(
          create: (_) => TipBloc(tipRepository)..add(LoadTips()),
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
