import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/referral.dart';

void main() {
  group('Referral', () {
    late Referral pendingReferral;
    late Referral completedReferral;

    setUp(() {
      pendingReferral = Referral(
        id: 'ref123',
        referrerUserId: 'user1',
        refereeUserId: 'user2',
        refereeDisplayName: 'New User',
        status: ReferralStatus.pending,
        referralCode: 'ABC123',
        createdAt: DateTime(2024, 1, 1),
        expiresAt: DateTime(2024, 1, 8),
      );

      completedReferral = Referral(
        id: 'ref456',
        referrerUserId: 'user1',
        refereeUserId: 'user3',
        refereeDisplayName: 'Completed User',
        status: ReferralStatus.rewarded,
        referralCode: 'ABC123',
        referrerReward: 500,
        refereeReward: 250,
        createdAt: DateTime(2024, 1, 1),
        registeredAt: DateTime(2024, 1, 2),
        qualifiedAt: DateTime(2024, 1, 5),
        rewardedAt: DateTime(2024, 1, 5),
      );
    });

    group('isPending', () {
      test('returns true for pending status', () {
        expect(pendingReferral.isPending, true);
      });

      test('returns false for rewarded status', () {
        expect(completedReferral.isPending, false);
      });
    });

    group('isComplete', () {
      test('returns true for rewarded status', () {
        expect(completedReferral.isComplete, true);
      });

      test('returns false for pending status', () {
        expect(pendingReferral.isComplete, false);
      });
    });

    group('isExpired', () {
      test('returns true for expired status', () {
        final expiredRef = pendingReferral.copyWith(status: ReferralStatus.expired);
        expect(expiredRef.isExpired, true);
      });

      test('returns true when expiresAt is in the past', () {
        final pastRef = pendingReferral.copyWith(
          expiresAt: DateTime(2020, 1, 1),
        );
        expect(pastRef.isExpired, true);
      });

      test('returns false when not expired', () {
        final futureRef = pendingReferral.copyWith(
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        );
        expect(futureRef.isExpired, false);
      });
    });

    group('totalReward', () {
      test('calculates total reward correctly', () {
        expect(completedReferral.totalReward, 750); // 500 + 250
      });

      test('returns 0 for pending referral with no rewards', () {
        expect(pendingReferral.totalReward, 0);
      });
    });

    group('refereeInitials', () {
      test('returns initials from displayName', () {
        expect(pendingReferral.refereeInitials, 'NU');
      });

      test('returns initials from single word name', () {
        final singleName = pendingReferral.copyWith(refereeDisplayName: 'John');
        expect(singleName.refereeInitials, 'JO');
      });

      test('returns ?? for null displayName', () {
        final noName = pendingReferral.copyWith(
          refereeDisplayName: null,
          refereeUsername: null,
        );
        expect(noName.refereeInitials, '??');
      });

      test('uses username when displayName is null', () {
        final usernameOnly = pendingReferral.copyWith(
          refereeDisplayName: null,
          refereeUsername: 'johndoe',
        );
        expect(usernameOnly.refereeInitials, 'JO');
      });
    });
  });

  group('ReferralStats', () {
    test('stores all values correctly', () {
      const stats = ReferralStats(
        totalReferrals: 10,
        pendingReferrals: 3,
        completedReferrals: 7,
        totalEarned: 3500,
        referralCode: 'ABC123',
        referralLink: 'https://imali.co.za/ref/ABC123',
      );

      expect(stats.totalReferrals, 10);
      expect(stats.pendingReferrals, 3);
      expect(stats.completedReferrals, 7);
      expect(stats.totalEarned, 3500);
      expect(stats.referralCode, 'ABC123');
      expect(stats.referralLink, contains('ABC123'));
    });
  });

  group('ReferralStatus', () {
    test('all statuses are distinct', () {
      expect(ReferralStatus.pending, isNot(ReferralStatus.registered));
      expect(ReferralStatus.registered, isNot(ReferralStatus.qualified));
      expect(ReferralStatus.qualified, isNot(ReferralStatus.rewarded));
      expect(ReferralStatus.rewarded, isNot(ReferralStatus.expired));
    });
  });
}
