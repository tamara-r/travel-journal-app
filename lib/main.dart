import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_journal/config/theme/app_theme.dart';
import 'package:travel_journal/core/routes/app_routes.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/features/auth/presentation/login_screen.dart';
import 'package:travel_journal/features/home/presentation/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    Widget child;

    if (authState is AsyncLoading) {
      child = const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (authState.hasValue) {
      final user = authState.value;
      child = user == null ? const LoginScreen() : const HomeScreen();
    } else {
      child = const LoginScreen();
    }

    return MaterialApp(
      title: 'Travel Journal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // TODO: Uncomment the following lines to use dark theme
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,

      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: child,
    );
  }
}
