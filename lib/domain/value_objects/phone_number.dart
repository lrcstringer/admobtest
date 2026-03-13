import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/error/failures.dart';

part 'phone_number.freezed.dart';

/// Value object representing a validated South African phone number
@freezed
abstract class PhoneNumber with _$PhoneNumber {
  const factory PhoneNumber(String value) = _PhoneNumber;
  const PhoneNumber._();

  /// Create a PhoneNumber from user input, validating and normalizing
  static Either<Failure, PhoneNumber> create(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleaned.length < 10 || cleaned.length > 15) {
      return left(const Failure.invalidPhone());
    }

    // Normalize to E.164 format for South Africa
    String normalized;
    if (cleaned.startsWith('0')) {
      normalized = '+27${cleaned.substring(1)}';
    } else if (cleaned.startsWith('27')) {
      normalized = '+$cleaned';
    } else if (cleaned.startsWith('+27')) {
      normalized = cleaned;
    } else {
      return left(const Failure.invalidPhone());
    }

    // Validate length for SA numbers (+27 + 9 digits)
    if (normalized.length != 12) {
      return left(const Failure.invalidPhone());
    }

    return right(PhoneNumber(normalized));
  }

  /// Format for display: +27821234567 -> 082 123 4567
  String get displayFormat {
    if (value.startsWith('+27') && value.length == 12) {
      return '0${value.substring(3, 5)} ${value.substring(5, 8)} ${value.substring(8)}';
    }
    return value;
  }

  /// Get the local format: +27821234567 -> 0821234567
  String get localFormat {
    if (value.startsWith('+27') && value.length == 12) {
      return '0${value.substring(3)}';
    }
    return value;
  }
}
