import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/common/widgets/custom_button.dart';
import 'package:travel_journal/core/routes/app_routes.dart';
import 'package:travel_journal/core/utils/form_validators.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/common/widgets/custom_text_field.dart';
import 'package:travel_journal/common/widgets/password_visibility_toggle.dart';
import 'package:travel_journal/common/widgets/password_criteria_indicator.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authControllerProvider.notifier).signUp(
            fullName: _fullNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            phoneNumber: _phoneNumberController.text.trim(),
          );

      if (!kIsWeb) {
        await ref.read(authControllerProvider.notifier).verifyPhoneNumber(
              phoneNumber: _phoneNumberController.text.trim(),
              codeSent: (verificationId) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.otp,
                  arguments: verificationId,
                );
              },
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              },
            );
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final password = _passwordController.text;

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
                  "Sign Up",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: "Full Name",
                controller: _fullNameController,
                validator: FormValidators.validateFullName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Phone Number",
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                validator: FormValidators.validatePhoneNumber,
              ),
              const SizedBox(height: 16),
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
                onChanged: (_) => setState(() {}),
                suffixIcon: PasswordVisibilityToggle(
                  isVisible: !_obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 8),
              PasswordCriteriaIndicator(
                text: "At least 6 characters",
                isValid: FormValidators.hasMinLength(password, 6),
              ),
              PasswordCriteriaIndicator(
                text: "Contains a lowercase letter",
                isValid: FormValidators.hasLowercase(password),
              ),
              PasswordCriteriaIndicator(
                text: "Contains a number",
                isValid: FormValidators.hasDigit(password),
              ),
              PasswordCriteriaIndicator(
                text: "Contains special character",
                isValid: FormValidators.hasSpecialChar(password),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Confirm Password",
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                validator: (value) => FormValidators.validateConfirmPassword(
                  value,
                  _passwordController.text,
                ),
                suffixIcon: PasswordVisibilityToggle(
                  isVisible: !_obscureConfirmPassword,
                  onToggle: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: _register,
                isLoading: _isLoading,
                text: "Sign Up",
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                    child: const Text(
                      "Sign In",
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
