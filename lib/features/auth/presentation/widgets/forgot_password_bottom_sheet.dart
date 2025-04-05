import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/common/widgets/custom_button.dart';
import 'package:travel_journal/common/widgets/custom_text_field.dart';
import 'package:travel_journal/core/utils/form_validators.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';

class ForgotPasswordBottomSheet extends ConsumerStatefulWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  ConsumerState<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState
    extends ConsumerState<ForgotPasswordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authControllerProvider.notifier)
          .sendPasswordResetEmail(_emailController.text.trim());

      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reset link sent to your email.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          top: 50,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "Enter your email address",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
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
                onPressed: _isLoading ? null : _sendResetEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
