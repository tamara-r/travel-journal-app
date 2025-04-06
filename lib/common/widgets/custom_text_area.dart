import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final void Function(String)? onChanged;

  const CustomTextArea({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.maxLines = 4,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 1.5,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: TextInputType.multiline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        alignLabelWithHint: true,
        errorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: focusedBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }
}
