/// Input Validator
/// Validates and sanitizes user input to prevent attacks
library;

class InputValidator {
  // Phone number validation (South African format)
  static final RegExp _saPhoneRegex = RegExp(r'^(\+27|0)[6-8][0-9]{8}$');

  // Email validation
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Alphanumeric with spaces (for names)
  static final RegExp _nameRegex = RegExp(r'^[a-zA-Z\s]{2,50}$');

  // Referral code format
  static final RegExp _referralCodeRegex = RegExp(r'^[A-Z0-9]{6,10}$');

  // PIN format (4-6 digits)
  static final RegExp _pinRegex = RegExp(r'^[0-9]{4,6}$');

  // Prevent SQL injection patterns
  static final RegExp _sqlInjectionRegex = RegExp(
    r'(\b(SELECT|INSERT|UPDATE|DELETE|DROP|UNION|ALTER|CREATE|TRUNCATE)\b)|([";])|(--)',
    caseSensitive: false,
  );

  // Prevent script injection
  static final RegExp _scriptInjectionRegex = RegExp(
    r'<script|javascript:|on\w+\s*=',
    caseSensitive: false,
  );

  /// Validate South African phone number
  static ValidationResult validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return ValidationResult.invalid('Phone number is required');
    }

    final cleaned = phone.replaceAll(RegExp(r'[\s\-()]'), '');

    if (!_saPhoneRegex.hasMatch(cleaned)) {
      return ValidationResult.invalid('Invalid South African phone number');
    }

    return ValidationResult.valid(cleaned);
  }

  /// Validate email address
  static ValidationResult validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return ValidationResult.invalid('Email is required');
    }

    final trimmed = email.trim().toLowerCase();

    if (trimmed.length > 254) {
      return ValidationResult.invalid('Email is too long');
    }

    if (!_emailRegex.hasMatch(trimmed)) {
      return ValidationResult.invalid('Invalid email address');
    }

    return ValidationResult.valid(trimmed);
  }

  /// Validate display name
  static ValidationResult validateDisplayName(String? name) {
    if (name == null || name.isEmpty) {
      return ValidationResult.invalid('Name is required');
    }

    final trimmed = name.trim();

    if (trimmed.length < 2) {
      return ValidationResult.invalid('Name must be at least 2 characters');
    }

    if (trimmed.length > 50) {
      return ValidationResult.invalid('Name must be less than 50 characters');
    }

    if (!_nameRegex.hasMatch(trimmed)) {
      return ValidationResult.invalid('Name can only contain letters and spaces');
    }

    if (_containsMaliciousContent(trimmed)) {
      return ValidationResult.invalid('Invalid characters in name');
    }

    return ValidationResult.valid(trimmed);
  }

  /// Validate referral code
  static ValidationResult validateReferralCode(String? code) {
    if (code == null || code.isEmpty) {
      return ValidationResult.invalid('Referral code is required');
    }

    final cleaned = code.trim().toUpperCase();

    if (!_referralCodeRegex.hasMatch(cleaned)) {
      return ValidationResult.invalid('Invalid referral code format');
    }

    return ValidationResult.valid(cleaned);
  }

  /// Validate PIN
  static ValidationResult validatePin(String? pin) {
    if (pin == null || pin.isEmpty) {
      return ValidationResult.invalid('PIN is required');
    }

    if (!_pinRegex.hasMatch(pin)) {
      return ValidationResult.invalid('PIN must be 4-6 digits');
    }

    // Check for weak PINs
    if (_isWeakPin(pin)) {
      return ValidationResult.invalid('PIN is too weak. Avoid sequential or repeated digits.');
    }

    return ValidationResult.valid(pin);
  }

  /// Validate token amount
  static ValidationResult validateTokenAmount(int? amount, {int? maxAmount}) {
    if (amount == null) {
      return ValidationResult.invalid('Amount is required');
    }

    if (amount <= 0) {
      return ValidationResult.invalid('Amount must be greater than 0');
    }

    if (maxAmount != null && amount > maxAmount) {
      return ValidationResult.invalid('Amount exceeds maximum allowed ($maxAmount)');
    }

    // Reasonable maximum (10 million tokens = R100,000)
    if (amount > 10000000) {
      return ValidationResult.invalid('Amount exceeds system maximum');
    }

    return ValidationResult.valid(amount.toString());
  }

  /// Validate message content
  static ValidationResult validateMessage(String? message) {
    if (message == null || message.isEmpty) {
      return ValidationResult.valid(''); // Empty messages allowed
    }

    final trimmed = message.trim();

    if (trimmed.length > 1000) {
      return ValidationResult.invalid('Message is too long (max 1000 characters)');
    }

    if (_containsMaliciousContent(trimmed)) {
      return ValidationResult.invalid('Message contains invalid content');
    }

    return ValidationResult.valid(trimmed);
  }

  /// Sanitize general text input
  static String sanitize(String input) {
    return input
        .trim()
        .replaceAll(_scriptInjectionRegex, '')
        .replaceAll(RegExp(r'[\x00-\x1F\x7F]'), ''); // Remove control characters
  }

  /// Check if input contains malicious content
  static bool _containsMaliciousContent(String input) {
    return _sqlInjectionRegex.hasMatch(input) ||
        _scriptInjectionRegex.hasMatch(input);
  }

  /// Check if PIN is weak
  static bool _isWeakPin(String pin) {
    // Check for all same digits (1111, 2222, etc.)
    if (pin.split('').toSet().length == 1) {
      return true;
    }

    // Check for sequential patterns
    const sequentialPatterns = [
      '0123', '1234', '2345', '3456', '4567', '5678', '6789',
      '9876', '8765', '7654', '6543', '5432', '4321', '3210',
      '01234', '12345', '23456', '34567', '45678', '56789',
      '98765', '87654', '76543', '65432', '54321', '43210',
      '012345', '123456', '234567', '345678', '456789',
      '987654', '876543', '765432', '654321', '543210',
    ];

    for (final pattern in sequentialPatterns) {
      if (pin.contains(pattern)) {
        return true;
      }
    }

    // Check for common weak PINs
    const weakPins = ['0000', '1111', '2222', '1212', '6969', '1313'];
    if (weakPins.contains(pin)) {
      return true;
    }

    return false;
  }
}

/// Result of validation
class ValidationResult {
  final bool isValid;
  final String? sanitizedValue;
  final String? errorMessage;

  const ValidationResult._({
    required this.isValid,
    this.sanitizedValue,
    this.errorMessage,
  });

  factory ValidationResult.valid(String value) {
    return ValidationResult._(isValid: true, sanitizedValue: value);
  }

  factory ValidationResult.invalid(String message) {
    return ValidationResult._(isValid: false, errorMessage: message);
  }
}
