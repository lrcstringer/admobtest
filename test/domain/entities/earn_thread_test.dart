import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/earn_thread.dart';

void main() {
  group('EarnThread', () {
    EarnThread createThread({
      String id = 'thread_001',
      String clientId = 'client_001',
      String clientName = 'Test Client',
      String? clientAvatarImage,
      String? clientAvatarColor,
      String title = 'Test Thread',
      bool isPinned = false,
      bool isFeatured = false,
      bool isActive = true,
      DateTime? activeFrom,
      DateTime? activeTo,
      int availableOpportunities = 5,
      int completedOpportunities = 100,
      int completedUniqueUsers = 50,
      DateTime? createdAt,
    }) {
      return EarnThread(
        id: id,
        clientId: clientId,
        clientName: clientName,
        clientAvatarImage: clientAvatarImage,
        clientAvatarColor: clientAvatarColor,
        title: title,
        isPinned: isPinned,
        isFeatured: isFeatured,
        isActive: isActive,
        activeFrom: activeFrom,
        activeTo: activeTo,
        availableOpportunities: availableOpportunities,
        completedOpportunities: completedOpportunities,
        completedUniqueUsers: completedUniqueUsers,
        createdAt: createdAt ?? DateTime.now(),
      );
    }

    group('clientInitials', () {
      test('returns two initials for two-word name', () {
        final thread = createThread(clientName: 'Test Brand');
        expect(thread.clientInitials, equals('TB'));
      });

      test('returns two initials for multi-word name', () {
        final thread = createThread(clientName: 'My Test Brand Company');
        expect(thread.clientInitials, equals('MT'));
      });

      test('returns first two characters for single-word name', () {
        final thread = createThread(clientName: 'Vodacom');
        expect(thread.clientInitials, equals('VO'));
      });

      test('returns single character if name has only one char', () {
        final thread = createThread(clientName: 'V');
        expect(thread.clientInitials, equals('V'));
      });

      test('returns ?? for empty name', () {
        final thread = createThread(clientName: '');
        expect(thread.clientInitials, equals('??'));
      });

      test('returns uppercase initials', () {
        final thread = createThread(clientName: 'test brand');
        expect(thread.clientInitials, equals('TB'));
      });
    });

    group('brandInitials (legacy alias)', () {
      test('returns same as clientInitials', () {
        final thread = createThread(clientName: 'Test Brand');
        expect(thread.brandInitials, equals(thread.clientInitials));
      });
    });

    group('hasAvailable', () {
      test('returns true when availableOpportunities > 0', () {
        final thread = createThread(availableOpportunities: 5);
        expect(thread.hasAvailable, isTrue);
      });

      test('returns false when availableOpportunities is 0', () {
        final thread = createThread(availableOpportunities: 0);
        expect(thread.hasAvailable, isFalse);
      });

      test('returns true when availableOpportunities is 1', () {
        final thread = createThread(availableOpportunities: 1);
        expect(thread.hasAvailable, isTrue);
      });
    });

    group('isCurrentlyActive', () {
      test('returns false when isActive is false', () {
        final thread = createThread(isActive: false);
        expect(thread.isCurrentlyActive, isFalse);
      });

      test('returns true when isActive and no scheduling', () {
        final thread = createThread(
          isActive: true,
          activeFrom: null,
          activeTo: null,
        );
        expect(thread.isCurrentlyActive, isTrue);
      });

      test('returns false when before activeFrom', () {
        final thread = createThread(
          isActive: true,
          activeFrom: DateTime.now().add(const Duration(days: 1)),
        );
        expect(thread.isCurrentlyActive, isFalse);
      });

      test('returns false when after activeTo', () {
        final thread = createThread(
          isActive: true,
          activeTo: DateTime.now().subtract(const Duration(days: 1)),
        );
        expect(thread.isCurrentlyActive, isFalse);
      });

      test('returns true when within schedule window', () {
        final thread = createThread(
          isActive: true,
          activeFrom: DateTime.now().subtract(const Duration(days: 1)),
          activeTo: DateTime.now().add(const Duration(days: 1)),
        );
        expect(thread.isCurrentlyActive, isTrue);
      });

      test('returns true when after activeFrom with no activeTo', () {
        final thread = createThread(
          isActive: true,
          activeFrom: DateTime.now().subtract(const Duration(days: 1)),
          activeTo: null,
        );
        expect(thread.isCurrentlyActive, isTrue);
      });

      test('returns true when before activeTo with no activeFrom', () {
        final thread = createThread(
          isActive: true,
          activeFrom: null,
          activeTo: DateTime.now().add(const Duration(days: 1)),
        );
        expect(thread.isCurrentlyActive, isTrue);
      });
    });

    group('hasTargeting', () {
      test('returns false when targeting is null', () {
        final thread = createThread();
        expect(thread.hasTargeting, isFalse);
      });
    });

    group('targetingSummary', () {
      test('returns "All users" when no targeting', () {
        final thread = createThread();
        expect(thread.targetingSummary, equals('All users'));
      });
    });

    group('default values', () {
      test('completedUniqueUsers defaults to 0', () {
        final thread = EarnThread(
          id: 'thread',
          clientId: 'client',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 100,
          createdAt: DateTime.now(),
        );
        expect(thread.completedUniqueUsers, equals(0));
      });
    });

    group('equality', () {
      test('two threads with same values are equal', () {
        final createdAt = DateTime.now();
        final thread1 = EarnThread(
          id: 'thread',
          clientId: 'client',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 100,
          createdAt: createdAt,
        );
        final thread2 = EarnThread(
          id: 'thread',
          clientId: 'client',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 100,
          createdAt: createdAt,
        );
        expect(thread1, equals(thread2));
      });

      test('threads with different IDs are not equal', () {
        final createdAt = DateTime.now();
        final thread1 = EarnThread(
          id: 'thread1',
          clientId: 'client',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 100,
          createdAt: createdAt,
        );
        final thread2 = EarnThread(
          id: 'thread2',
          clientId: 'client',
          clientName: 'Test',
          title: 'Test',
          isPinned: false,
          isFeatured: false,
          isActive: true,
          availableOpportunities: 5,
          completedOpportunities: 100,
          createdAt: createdAt,
        );
        expect(thread1, isNot(equals(thread2)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated values', () {
        final original = createThread(
          clientName: 'Original',
          isActive: true,
        );
        final updated = original.copyWith(
          clientName: 'Updated',
          isActive: false,
        );

        expect(updated.clientName, equals('Updated'));
        expect(updated.isActive, isFalse);
        expect(updated.id, equals(original.id));
      });
    });
  });
}
