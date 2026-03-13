import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/error/failures.dart';
import '../../core/constants/app_constants.dart';

part 'token_amount.freezed.dart';

/// Value object representing a validated token amount
@freezed
abstract class TokenAmount with _$TokenAmount {
  const factory TokenAmount(int value) = _TokenAmount;
  const TokenAmount._();

  /// Create a TokenAmount, validating it's non-negative
  static Either<Failure, TokenAmount> create(int value) {
    if (value < 0) {
      return left(const Failure.invalidAmount());
    }
    return right(TokenAmount(value));
  }

  /// Create from ZAR amount
  static TokenAmount fromZar(double zar) {
    return TokenAmount((zar / AppConstants.tokenValueZar).round());
  }

  /// Zero tokens
  static const TokenAmount zero = TokenAmount(0);

  /// Convert to ZAR
  double get toZar => value * AppConstants.tokenValueZar;

  /// Format as token string: "1,234"
  String get formatted {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }

  /// Format as ZAR: "R 12.34"
  String get formattedZar => 'R ${toZar.toStringAsFixed(2)}';

  /// Check if amount meets cashout minimum
  bool get meetsCashoutMinimum => value >= AppConstants.cashoutMinTokens;

  /// Arithmetic operations
  TokenAmount operator +(TokenAmount other) => TokenAmount(value + other.value);
  TokenAmount operator -(TokenAmount other) => TokenAmount(value - other.value);
  TokenAmount operator *(int multiplier) => TokenAmount(value * multiplier);

  /// Comparison
  bool operator <(TokenAmount other) => value < other.value;
  bool operator <=(TokenAmount other) => value <= other.value;
  bool operator >(TokenAmount other) => value > other.value;
  bool operator >=(TokenAmount other) => value >= other.value;
}
