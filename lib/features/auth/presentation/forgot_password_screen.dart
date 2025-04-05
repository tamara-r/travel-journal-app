import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Forgot Password"),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(authControllerProvider.notifier)
                    .sendPasswordResetEmail(emailController.text.trim());
              },
              child: const Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
