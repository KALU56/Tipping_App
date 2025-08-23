// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await init();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Tips',
      theme: AppTheme.light,
      onGenerateRoute: AppRouter.generateRoute,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // Check auth status when app starts
          context.read<AuthBloc>().add(CheckAuthStatus());
          
          if (state is Authenticated) {
            return HomeScreen();
          }
          return LandingScreen();
        },
      ),
    );
  }
}