import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core Services
import 'package:tip_employee/src/core/service/http_service/http_service.dart';
import 'package:tip_employee/src/core/service/auth_service.dart';
import 'package:tip_employee/src/core/service/transaction_service.dart';
import 'package:tip_employee/src/core/service/user_service.dart';
import 'package:tip_employee/src/core/service/account_service.dart';
import 'package:tip_employee/src/core/service/cloudinary_service.dart';

// Repositories & Services
import 'package:tip_employee/src/features/tip/data/transaction_repository_impl.dart';
import 'package:tip_employee/src/features/tip/domain/transaction_repository.dart';

import 'package:tip_employee/src/shared/data/UserRepositoryImpl.dart';
import 'package:tip_employee/src/features/settings/data/user_s_repository_impl.dart';
import 'package:tip_employee/src/features/settings/data/bank_account_repository_impl.dart';
import 'package:tip_employee/src/features/auth/data/repositories/auth_repository_impl.dart';

// Domain
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';
import 'package:tip_employee/src/features/auth/domain/repositories/auth_repository.dart';

// Blocs
import 'package:tip_employee/src/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tip_employee/src/features/home/presentation/blocs/home_bloc.dart';
import 'package:tip_employee/src/features/home/presentation/blocs/home_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_bloc.dart';
import 'package:tip_employee/src/features/tip/presentation/blocs/tip_bloc.dart';

// Routes & Theme
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/routes/route_generator.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/app/themes/themeNotifier.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // --- Initialize core services ---
  final httpService = HttpServiceImpl();
  final authService = AuthService(httpService);
  final cloudinaryService = CloudinaryService(
    cloudName: 'dvkismvdn',
    uploadPreset: 'tiptop',
  );
  final userService = UserService(
    httpService: httpService,
    cloudinaryService: cloudinaryService,
  );
  final accountService = AccountService(httpService: httpService);

  // --- Initialize repositories ---
  final authRepository = AuthRepositoryImpl(authService);
  final userRepository = UserRepositoryImpl(userService: userService);
  final userSettingRepository = UserSettingRepositoryImpl(userService: userService);
  final bankAccountRepository = BankAccountRepositoryImpl(accountService: accountService);

  // --- Transaction: Service -> RepoImpl -> RepoInterface ---
  final transactionService = TransactionService(httpService);
  final transactionRepositoryImpl = TransactionRepositoryImpl(transactionService);
  final TransactionRepository transactionRepository = transactionRepositoryImpl;

  print('✅ Core services and repositories initialized');

  runApp(MyApp(
    authRepository: authRepository,
    userRepository: userRepository,
    userSettingRepository: userSettingRepository,
    bankAccountRepository: bankAccountRepository,
    transactionRepository: transactionRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final UserSettingRepository userSettingRepository;
  final BankAccountRepository bankAccountRepository;
  final TransactionRepository transactionRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.userRepository,
    required this.userSettingRepository,
    required this.bankAccountRepository,
    required this.transactionRepository,
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
            transactionRepository: transactionRepository,
          )
            ..add(FetchProfile())
            ..add(FetchTips()),
        ),
        BlocProvider<TipHistoryBloc>(
          create: (_) => TipHistoryBloc(transactionRepository: transactionRepository),
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
