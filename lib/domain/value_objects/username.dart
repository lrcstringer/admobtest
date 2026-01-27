import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/error/failures.dart';

part 'username.freezed.dart';

/// Value object representing a validated username
@freezed
class Username with _$Username {
  const factory Username(String value) = _Username;
  const Username._();

  /// Create a Username from user input, validating format
  static Either<Failure, Username> create(String input) {
    final trimmed = input.trim().toLowerCase();

    // Remove @ prefix if present
    final cleaned = trimmed.startsWith('@') ? trimmed.substring(1) : trimmed;

    // Validate length
    if (cleaned.length < 3 || cleaned.length > 20) {
      return left(const Failure.invalidUsername());
    }

    // Validate format: alphanumeric and underscores only
    final regex = RegExp(r'^[a-z0-9_]+$');
    if (!regex.hasMatch(cleaned)) {
      return left(const Failure.invalidUsername());
    }

    return right(Username(cleaned));
  }

  /// Display with @ prefix
  String get displayFormat => '@$value';
}
