/// Utility class for validation functions
class Validators {
  Validators._();

  /// Validate South African phone number
  /// Accepts formats: 0821234567, 27821234567, +27821234567
  static bool isValidSAPhoneNumber(String? value) {
    if (value == null || value.isEmpty) return false;

    final cleaned = value.replaceAll(RegExp(r'[^0-9+]'), '');

    // Check various formats
    if (cleaned.startsWith('+27')) {
      return cleaned.length == 12;
    } else if (cleaned.startsWith('27')) {
      return cleaned.length == 11;
    } else if (cleaned.startsWith('0')) {
      return cleaned.length == 10;
    }

    return false;
  }

  /// Normalize phone number to E.164 format (+27XXXXXXXXX)
  static String? normalizePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return null;

    final cleaned = value.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleaned.startsWith('+27') && cleaned.length == 12) {
      return cleaned;
    } else if (cleaned.startsWith('27') && cleaned.length == 11) {
      return '+$cleaned';
    } else if (cleaned.startsWith('0') && cleaned.length == 10) {
      return '+27${cleaned.substring(1)}';
    }

    return null;
  }

  /// Validate username (3-20 chars, alphanumeric and underscore, no spaces)
  static bool isValidUsername(String? value) {
    if (value == null || value.isEmpty) return false;

    final regex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    return regex.hasMatch(value);
  }

  /// Validate display name (2-50 chars, letters and spaces only)
  static bool isValidDisplayName(String? value) {
    if (value == null || value.isEmpty) return false;

    final trimmed = value.trim();
    if (trimmed.length < 2 || trimmed.length > 50) return false;

    final regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(trimmed);
  }

  /// Validate OTP code (6 digits)
  static bool isValidOtp(String? value) {
    if (value == null || value.isEmpty) return false;

    final regex = RegExp(r'^\d{6}$');
    return regex.hasMatch(value);
  }

  /// Validate token amount (positive integer)
  static bool isValidTokenAmount(int? value) {
    return value != null && value > 0;
  }

  /// Validate meter number for electricity (11-13 digits)
  static bool isValidMeterNumber(String? value) {
    if (value == null || value.isEmpty) return false;

    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    return cleaned.length >= 11 && cleaned.length <= 13;
  }

  /// Validate email address
  static bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) return false;

    final regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(value);
  }

  /// Check if user is at least 16 years old
  static bool isAtLeast16YearsOld(DateTime? dateOfBirth) {
    if (dateOfBirth == null) return false;

    final now = DateTime.now();
    final age = now.year - dateOfBirth.year;

    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      return age - 1 >= 16;
    }

    return age >= 16;
  }
}
