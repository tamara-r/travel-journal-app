import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/core/routes/app_routes.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authState = ref.read(authControllerProvider);

    authState.when(
      data: (user) {
        final targetRoute = user != null ? AppRoutes.home : AppRoutes.login;

        // Prevent navigating multiple times
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, targetRoute);
        });
      },
      loading: () {},
      error: (_, __) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
