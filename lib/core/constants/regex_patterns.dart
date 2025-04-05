class RegexPatterns {
  /// International phone number pattern (simplified version)
  static final RegExp phone = RegExp(
    r'^\+?\d{1,4}[-.\s]?\(?\d+\)?([-.\s]?\d+)*$',
  );

  /// Email address pattern
  static final RegExp email = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    caseSensitive: false,
  );
}
