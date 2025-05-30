import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/common/widgets/custom_button.dart';
import 'package:travel_journal/core/routes/app_routes.dart';
import 'package:travel_journal/core/utils/form_validators.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/common/widgets/custom_text_field.dart';
import 'package:travel_journal/common/widgets/password_visibility_toggle.dart';
import 'package:travel_journal/features/auth/domain/provider/auth_error_provider.dart';
import 'package:travel_journal/features/auth/presentation/widgets/forgot_password_bottom_sheet.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    final errorNotifier = ref.read(authErrorProvider.notifier);
    errorNotifier.state = null;

    setState(() => _isLoading = true);

    final authController = ref.read(authControllerProvider.notifier);

    try {
      await authController.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'invalid-email' => 'The email address is invalid.',
        'user-disabled' => 'This account has been disabled.',
        'user-not-found' => 'No account found for this email.',
        'wrong-password' ||
        'invalid-credential' =>
          'Incorrect email or password.',
        _ => 'Login failed. Please try again.',
      };

      errorNotifier.state = message;
    } catch (_) {
      errorNotifier.state = 'Something went wrong. Please try again.';
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authErrorMessage = ref.watch(authErrorProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Center(
                child: Image.asset(
                  'assets/images/map.png',
                  height: 160,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: "Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.validateEmail,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Password",
                controller: _passwordController,
                obscureText: _obscurePassword,
                validator: FormValidators.validatePassword,
                onChanged: (_) {
                  final notifier = ref.read(authErrorProvider.notifier);
                  if (notifier.state != null) {
                    notifier.state = null;
                  }
                },
                suffixIcon: PasswordVisibilityToggle(
                  isVisible: !_obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const ForgotPasswordBottomSheet(),
                    );
                  },
                  child: const Text("Forgot password?"),
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(
                onPressed: _login,
                isLoading: _isLoading,
                text: "Sign In",
              ),
              if (authErrorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  authErrorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
