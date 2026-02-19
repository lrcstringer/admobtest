import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/auth_challenge.dart';

void main() {
  group('AuthChallenge', () {
    AuthChallenge createChallenge({
      String challengeId = 'challenge_001',
      String userId = 'user_001',
      String nonce = 'abc123nonce',
      ChallengeStatus status = ChallengeStatus.pending,
      DateTime? createdAt,
      DateTime? expiresAt,
      String? deviceId,
      DateTime? respondedAt,
    }) {
      return AuthChallenge(
        challengeId: challengeId,
        userId: userId,
        nonce: nonce,
        status: status,
        createdAt: createdAt ?? DateTime.now(),
        expiresAt: expiresAt ?? DateTime.now().add(const Duration(minutes: 3)),
        deviceId: deviceId,
        respondedAt: respondedAt,
      );
    }

    group('isExpired', () {
      test('returns false when expiresAt is in the future', () {
        final challenge = createChallenge(
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );
        expect(challenge.isExpired, isFalse);
      });

      test('returns true when expiresAt is in the past', () {
        final challenge = createChallenge(
          expiresAt: DateTime.now().subtract(const Duration(hours: 1)),
        );
        expect(challenge.isExpired, isTrue);
      });
    });

    group('isActionable', () {
      test('returns true when status is pending and not expired', () {
        final challenge = createChallenge(
          status: ChallengeStatus.pending,
          expiresAt: DateTime.now().add(const Duration(minutes: 5)),
        );
        expect(challenge.isActionable, isTrue);
      });

      test('returns false when status is pending but expired', () {
        final challenge = createChallenge(
          status: ChallengeStatus.pending,
          expiresAt: DateTime.now().subtract(const Duration(minutes: 1)),
        );
        expect(challenge.isActionable, isFalse);
      });

      test('returns false when status is approved and not expired', () {
        final challenge = createChallenge(
          status: ChallengeStatus.approved,
          expiresAt: DateTime.now().add(const Duration(minutes: 5)),
        );
        expect(challenge.isActionable, isFalse);
      });

      test('returns false when status is denied and not expired', () {
        final challenge = createChallenge(
          status: ChallengeStatus.denied,
          expiresAt: DateTime.now().add(const Duration(minutes: 5)),
        );
        expect(challenge.isActionable, isFalse);
      });

      test('returns false when status is expired enum value', () {
        final challenge = createChallenge(
          status: ChallengeStatus.expired,
          expiresAt: DateTime.now().add(const Duration(minutes: 5)),
        );
        expect(challenge.isActionable, isFalse);
      });
    });

    group('construction', () {
      test('creates with all required fields', () {
        final now = DateTime.now();
        final expires = now.add(const Duration(minutes: 3));
        final challenge = AuthChallenge(
          challengeId: 'ch_123',
          userId: 'u_456',
          nonce: 'nonce789',
          status: ChallengeStatus.pending,
          createdAt: now,
          expiresAt: expires,
        );

        expect(challenge.challengeId, equals('ch_123'));
        expect(challenge.userId, equals('u_456'));
        expect(challenge.nonce, equals('nonce789'));
        expect(challenge.status, equals(ChallengeStatus.pending));
        expect(challenge.createdAt, equals(now));
        expect(challenge.expiresAt, equals(expires));
      });

      test('deviceId defaults to null', () {
        final challenge = createChallenge();
        expect(challenge.deviceId, isNull);
      });

      test('respondedAt defaults to null', () {
        final challenge = createChallenge();
        expect(challenge.respondedAt, isNull);
      });

      test('accepts optional deviceId and respondedAt', () {
        final responded = DateTime.now();
        final challenge = createChallenge(
          deviceId: 'device_abc',
          respondedAt: responded,
        );
        expect(challenge.deviceId, equals('device_abc'));
        expect(challenge.respondedAt, equals(responded));
      });
    });

    group('copyWith', () {
      test('preserves all fields when no overrides given', () {
        final now = DateTime.now();
        final expires = now.add(const Duration(minutes: 3));
        final original = AuthChallenge(
          challengeId: 'ch_1',
          userId: 'u_1',
          nonce: 'nonce_1',
          status: ChallengeStatus.pending,
          createdAt: now,
          expiresAt: expires,
          deviceId: 'dev_1',
          respondedAt: now,
        );

        final copy = original.copyWith();

        expect(copy.challengeId, equals(original.challengeId));
        expect(copy.userId, equals(original.userId));
        expect(copy.nonce, equals(original.nonce));
        expect(copy.status, equals(original.status));
        expect(copy.createdAt, equals(original.createdAt));
        expect(copy.expiresAt, equals(original.expiresAt));
        expect(copy.deviceId, equals(original.deviceId));
        expect(copy.respondedAt, equals(original.respondedAt));
      });

      test('overrides specific fields while preserving others', () {
        final original = createChallenge(
          challengeId: 'ch_original',
          status: ChallengeStatus.pending,
        );

        final updated = original.copyWith(
          status: ChallengeStatus.approved,
          respondedAt: DateTime.now(),
        );

        expect(updated.status, equals(ChallengeStatus.approved));
        expect(updated.respondedAt, isNotNull);
        expect(updated.challengeId, equals('ch_original'));
        expect(updated.userId, equals(original.userId));
        expect(updated.nonce, equals(original.nonce));
      });
    });

    group('edge cases', () {
      test('challenge created seconds ago is not expired', () {
        final now = DateTime.now();
        final challenge = AuthChallenge(
          challengeId: 'ch_fresh',
          userId: 'u_1',
          nonce: 'nonce_fresh',
          status: ChallengeStatus.pending,
          createdAt: now.subtract(const Duration(seconds: 5)),
          expiresAt: now.add(const Duration(minutes: 3)),
        );

        expect(challenge.isExpired, isFalse);
        expect(challenge.isActionable, isTrue);
      });
    });
  });
}
