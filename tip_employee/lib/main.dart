import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/core/service/account_service.dart';
import 'package:tip_employee/src/core/service/cloudinary_service.dart';

// Core services
import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/auth_service.dart';
import 'package:tip_employee/src/core/service/user_service.dart';

// Auth
import 'package:tip_employee/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:tip_employee/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tip_employee/src/features/auth/presentation/blocs/auth_bloc.dart';

// Home
import 'package:tip_employee/src/features/home/presentation/blocs/home_bloc.dart';
import 'package:tip_employee/src/features/home/presentation/blocs/home_event.dart';
import 'package:tip_employee/src/features/settings/data/bank_account_repository_impl.dart';
import 'package:tip_employee/src/features/settings/data/user_s_repository_impl.dart';
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';

// Settings
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_bloc.dart';

import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';
import 'package:tip_employee/src/shared/data/UserRepositoryImpl.dart';


// Tip
import 'package:tip_employee/src/features/tip/presentation/blocs/tip_bloc.dart';
import 'package:tip_employee/src/features/tip/presentation/blocs/tip_event.dart';
import 'package:tip_employee/src/shared/domain/repositories/tip_repository.dart';
import 'package:tip_employee/src/shared/data/mock_tip_repository.dart';

// App
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/routes/route_generator.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/app/themes/themeNotifier.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  final httpService = HttpServiceImpl();
  final authService = AuthService(httpService);
  
  // Cloudinary service
  final cloudinaryService = CloudinaryService(
    cloudName: 'dvkismvdn',
    uploadPreset: 'tiptop',
  );

  // User service with both HTTP and Cloudinary
  final userService = UserService(
    httpService: httpService,
    cloudinaryService: cloudinaryService,
  );

  final authRepository = AuthRepositoryImpl(authService);
  final userRepository = UserRepositoryImpl(userService: userService);
  final userSettingRepository = UserSettingRepositoryImpl(userService: userService);
  final tipRepository = MockTipRepository(); // repl(ace with real repo
final bankAccountRepository = BankAccountRepositoryImpl(
  accountService: AccountService(httpService: httpService),
);
  runApp(MyApp(
    authRepository: authRepository,
    userRepository: userRepository,
    userSettingRepository: userSettingRepository,
    tipRepository: tipRepository,
    bankAccountRepository: bankAccountRepository,
    
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final UserSettingRepository userSettingRepository;
  final TipRepository tipRepository;
  final BankAccountRepository bankAccountRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.userRepository,
    required this.userSettingRepository,
    required this.tipRepository,
    required this.bankAccountRepository, 
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<SettingBloc>(
          create: (_) => SettingBloc(
            userRepository: userRepository,
            userSettingRepository: userSettingRepository,
            bankAccountRepository: bankAccountRepository,
          ),
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
