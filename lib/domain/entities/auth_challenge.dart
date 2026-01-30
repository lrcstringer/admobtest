import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_challenge.freezed.dart';

/// Status of a push-based authentication challenge.
enum ChallengeStatus {
  /// Challenge has been created and sent to device.
  pending,

  /// Challenge has been approved by the user.
  approved,

  /// Challenge has been denied by the user.
  denied,

  /// Challenge has expired (3-minute timeout).
  expired,
}

/// A push-based login challenge sent to a trusted device.
@freezed
class AuthChallenge with _$AuthChallenge {
  const factory AuthChallenge({
    required String challengeId,
    required String userId,
    required String nonce,
    required ChallengeStatus status,
    required DateTime createdAt,
    required DateTime expiresAt,
    String? deviceId,
    DateTime? respondedAt,
  }) = _AuthChallenge;

  const AuthChallenge._();

  /// Whether the challenge has expired.
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Whether the challenge is still pending and not expired.
  bool get isActionable => status == ChallengeStatus.pending && !isExpired;
}
