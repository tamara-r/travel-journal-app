import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/common/widgets/custom_button.dart';
import 'package:travel_journal/common/widgets/custom_text_field.dart';
import 'package:travel_journal/core/utils/form_validators.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  String? _statusMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      await ref
          .read(authControllerProvider.notifier)
          .sendPasswordResetEmail(_emailController.text.trim());

      setState(() {
        _statusMessage = "A password reset link has been sent to your email.";
      });
    } catch (e) {
      setState(() {
        _statusMessage = "Failed to send reset email. Please try again.";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Image.asset(
                'assets/images/map.png',
                height: 160,
              ),
              const SizedBox(height: 32),
              Text(
                "Forgot Password",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: "Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.validateEmail,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Send Reset Link",
                isLoading: _isLoading,
                onPressed: _resetPassword,
              ),
              if (_statusMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  _statusMessage!,
                  style: TextStyle(
                    color: _statusMessage!.startsWith("Failed")
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
