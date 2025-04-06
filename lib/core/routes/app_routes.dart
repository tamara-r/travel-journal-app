import 'package:flutter/material.dart';
import 'package:travel_journal/app/navigation/main_navigation_screen.dart';
import 'package:travel_journal/features/auth/presentation/forgot_password_screen.dart';
import 'package:travel_journal/features/auth/presentation/login_screen.dart';
import 'package:travel_journal/features/auth/presentation/otp_screen.dart';
import 'package:travel_journal/features/auth/presentation/register_screen.dart';
import 'package:travel_journal/features/auth/presentation/reset_password.dart';
import 'package:travel_journal/features/auth/presentation/splash_screen.dart';
import 'package:travel_journal/features/home/presentation/home_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case otp:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
