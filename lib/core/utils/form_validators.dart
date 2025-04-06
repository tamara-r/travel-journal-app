import 'package:travel_journal/core/constants/regex_patterns.dart';

class FormValidators {
  // --- Full Name ---
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    return null;
  }

  // --- Email ---
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    } else if (!RegexPatterns.email.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // --- Phone Number ---
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    } else if (!RegexPatterns.phone.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // --- Password ---
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    } else if (!hasMinLength(value, 6)) {
      return 'Password must be at least 6 characters';
    } else if (!hasLowercase(value)) {
      return 'Password must contain a lowercase letter';
    } else if (!hasDigit(value)) {
      return 'Password must contain a number';
    } else if (!hasSpecialChar(value)) {
      return 'Password must contain a special character';
    }
    return null;
  }

  // --- Confirm Password ---
  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    } else if (value.trim() != original.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  // --- Helpers for visual criteria ---
  static bool hasUppercase(String input) => input.contains(RegExp(r'[A-Z]'));
  static bool hasLowercase(String input) => input.contains(RegExp(r'[a-z]'));
  static bool hasDigit(String input) => input.contains(RegExp(r'\d'));
  static bool hasSpecialChar(String input) =>
      input.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  static bool hasMinLength(String input, int min) => input.length >= min;

  // --- Validate Required Fields ---
  static String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
