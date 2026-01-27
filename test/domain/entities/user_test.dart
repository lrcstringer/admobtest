import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/entities/user_profile.dart';
import 'package:imalichat/domain/enums/user_status.dart';

void main() {
  group('User', () {
    late User activeUser;
    late User pendingUser;
    late User suspendedUser;

    setUp(() {
      activeUser = User(
        id: 'user123',
        phoneNumber: '+27612345678',
        status: UserStatus.active,
        isPotEligible: true,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: true,
        createdAt: DateTime(2024, 1, 1),
        profile: const UserProfile(
          displayName: 'John Doe',
          username: 'johndoe',
        ),
      );

      pendingUser = User(
        id: 'user456',
        phoneNumber: '+27712345678',
        status: UserStatus.pending,
        isPotEligible: false,
        hasAcceptedTerms: false,
        hasCompletedOnboarding: false,
        createdAt: DateTime(2024, 1, 1),
      );

      suspendedUser = User(
        id: 'user789',
        phoneNumber: '+27812345678',
        status: UserStatus.suspended,
        isPotEligible: false,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: true,
        createdAt: DateTime(2024, 1, 1),
      );
    });

    group('isVerified', () {
      test('returns true when status is active', () {
        expect(activeUser.isVerified, true);
      });

      test('returns false when status is pending', () {
        expect(pendingUser.isVerified, false);
      });

      test('returns false when status is suspended', () {
        expect(suspendedUser.isVerified, false);
      });
    });

    group('canEarn', () {
      test('returns true when verified and has profile', () {
        expect(activeUser.canEarn, true);
      });

      test('returns false when not verified', () {
        expect(pendingUser.canEarn, false);
      });

      test('returns false when verified but no profile', () {
        final userNoProfile = activeUser.copyWith(profile: null);
        expect(userNoProfile.canEarn, false);
      });
    });

    group('needsOnboarding', () {
      test('returns true when not completed onboarding', () {
        expect(pendingUser.needsOnboarding, true);
      });

      test('returns true when hasnt accepted terms', () {
        final userNoTerms = activeUser.copyWith(hasAcceptedTerms: false);
        expect(userNoTerms.needsOnboarding, true);
      });

      test('returns false when completed and accepted terms', () {
        expect(activeUser.needsOnboarding, false);
      });
    });

    group('isPotEligibleNow', () {
      test('returns false when isPotEligible is false', () {
        expect(pendingUser.isPotEligibleNow, false);
      });

      test('returns false when potEligibleAt is null', () {
        final userNoPotDate = activeUser.copyWith(potEligibleAt: null);
        expect(userNoPotDate.isPotEligibleNow, false);
      });

      test('returns true when potEligibleAt is in the past', () {
        final userWithPotDate = activeUser.copyWith(
          potEligibleAt: DateTime(2020, 1, 1),
        );
        expect(userWithPotDate.isPotEligibleNow, true);
      });

      test('returns false when potEligibleAt is in the future', () {
        final userWithFuturePotDate = activeUser.copyWith(
          potEligibleAt: DateTime.now().add(const Duration(days: 7)),
        );
        expect(userWithFuturePotDate.isPotEligibleNow, false);
      });
    });

    group('displayName', () {
      test('returns profile displayName when available', () {
        expect(activeUser.displayName, 'John Doe');
      });

      test('returns @username when displayName is empty', () {
        final userNoDisplayName = activeUser.copyWith(
          profile: const UserProfile(displayName: '', username: 'johndoe'),
        );
        expect(userNoDisplayName.displayName, '@johndoe');
      });

      test('returns phoneNumber when no profile', () {
        final userNoProfile = activeUser.copyWith(profile: null);
        expect(userNoProfile.displayName, '+27612345678');
      });
    });

    group('initials', () {
      test('returns initials from displayName', () {
        expect(activeUser.initials, 'JD');
      });

      test('returns first two characters for single name', () {
        final userSingleName = activeUser.copyWith(
          profile: const UserProfile(displayName: 'John'),
        );
        expect(userSingleName.initials, 'JO');
      });

      test('returns ?? when no profile', () {
        final userNoProfile = activeUser.copyWith(profile: null);
        expect(userNoProfile.initials, '??');
      });
    });
  });
}
