import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/community.dart';
import 'package:imalichat/domain/enums/community_status.dart';
import 'package:imalichat/domain/enums/community_type.dart';

void main() {
  // ==================== HELPERS ====================

  Community createCommunity({
    String id = 'community_001',
    CommunityType type = CommunityType.regular,
    String name = 'Test Community',
    String? description = 'A test community',
    String? avatarUrl,
    String ownerId = 'owner_001',
    List<String> memberIds = const ['owner_001', 'admin_001', 'user_001'],
    List<String> adminIds = const ['owner_001', 'admin_001'],
    int memberCount = 3,
    int totalBalance = 0,
    CommunityStatus status = CommunityStatus.active,
    CommunitySettings? settings,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    DateTime? lastMessageAt,
    Map<String, int> unreadCounts = const {},
    Map<String, bool> muted = const {},
    Map<String, String> lastMessageEncryptedPreviews = const {},
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Community(
      id: id,
      type: type,
      name: name,
      description: description,
      avatarUrl: avatarUrl,
      ownerId: ownerId,
      memberIds: memberIds,
      adminIds: adminIds,
      memberCount: memberCount,
      totalBalance: totalBalance,
      status: status,
      settings: settings ?? const CommunitySettings(),
      lastMessageText: lastMessageText,
      lastMessageSenderId: lastMessageSenderId,
      lastMessageSenderName: lastMessageSenderName,
      lastMessageType: lastMessageType,
      lastMessageAt: lastMessageAt,
      unreadCounts: unreadCounts,
      muted: muted,
      lastMessageEncryptedPreviews: lastMessageEncryptedPreviews,
      createdAt: createdAt ?? DateTime(2024, 6, 1),
      updatedAt: updatedAt,
    );
  }

  // ==================== COMMUNITY TESTS ====================

  group('Community', () {
    group('entity creation', () {
      test('creates a valid community with required fields', () {
        final community = createCommunity();

        expect(community.id, equals('community_001'));
        expect(community.type, equals(CommunityType.regular));
        expect(community.name, equals('Test Community'));
        expect(community.description, equals('A test community'));
        expect(community.ownerId, equals('owner_001'));
        expect(community.memberIds.length, equals(3));
        expect(community.adminIds.length, equals(2));
        expect(community.memberCount, equals(3));
        expect(community.totalBalance, equals(0));
        expect(community.status, equals(CommunityStatus.active));
      });

      test('creates a stokvel community', () {
        final community = createCommunity(
          type: CommunityType.stokvel,
          settings: CommunitySettings.defaultFor(CommunityType.stokvel),
        );

        expect(community.isStokvel, isTrue);
        expect(community.hasFinancials, isTrue);
      });

      test('copyWith creates a modified copy', () {
        final original = createCommunity();
        final modified = original.copyWith(
          name: 'Updated Community',
          status: CommunityStatus.suspended,
        );

        expect(modified.name, equals('Updated Community'));
        expect(modified.status, equals(CommunityStatus.suspended));
        // Unchanged fields should remain the same
        expect(modified.id, equals(original.id));
        expect(modified.ownerId, equals(original.ownerId));
      });

      test('optional fields default to null', () {
        final community = createCommunity(
          description: null,
          avatarUrl: null,
          lastMessageText: null,
        );

        expect(community.description, isNull);
        expect(community.avatarUrl, isNull);
        expect(community.lastMessageText, isNull);
        expect(community.lastMessageAt, isNull);
      });
    });

    group('isActive / isSuspended / isClosed', () {
      test('isActive is true only when status is active', () {
        final active = createCommunity(status: CommunityStatus.active);
        final suspended = createCommunity(status: CommunityStatus.suspended);
        final closed = createCommunity(status: CommunityStatus.closed);

        expect(active.isActive, isTrue);
        expect(suspended.isActive, isFalse);
        expect(closed.isActive, isFalse);
      });

      test('isSuspended is true only when status is suspended', () {
        final active = createCommunity(status: CommunityStatus.active);
        final suspended = createCommunity(status: CommunityStatus.suspended);
        final closed = createCommunity(status: CommunityStatus.closed);

        expect(active.isSuspended, isFalse);
        expect(suspended.isSuspended, isTrue);
        expect(closed.isSuspended, isFalse);
      });

      test('isClosed is true only when status is closed', () {
        final active = createCommunity(status: CommunityStatus.active);
        final suspended = createCommunity(status: CommunityStatus.suspended);
        final closed = createCommunity(status: CommunityStatus.closed);

        expect(active.isClosed, isFalse);
        expect(suspended.isClosed, isFalse);
        expect(closed.isClosed, isTrue);
      });
    });

    group('isStokvel / hasFinancials', () {
      test('isStokvel returns true for stokvel type', () {
        final stokvel = createCommunity(type: CommunityType.stokvel);
        final regular = createCommunity(type: CommunityType.regular);

        expect(stokvel.isStokvel, isTrue);
        expect(regular.isStokvel, isFalse);
      });

      test('hasFinancials reflects settings.enableFinancials', () {
        final withFinancials = createCommunity(
          settings: const CommunitySettings(enableFinancials: true),
        );
        final withoutFinancials = createCommunity(
          settings: const CommunitySettings(enableFinancials: false),
        );

        expect(withFinancials.hasFinancials, isTrue);
        expect(withoutFinancials.hasFinancials, isFalse);
      });
    });

    group('hasValidAdmins', () {
      test('returns true when all admins are members', () {
        final community = createCommunity(
          memberIds: ['owner_001', 'admin_001', 'user_001'],
          adminIds: ['owner_001', 'admin_001'],
        );

        expect(community.hasValidAdmins, isTrue);
      });

      test('returns false when an admin is not a member', () {
        final community = createCommunity(
          memberIds: ['owner_001', 'user_001'],
          adminIds: ['owner_001', 'rogue_admin'],
        );

        expect(community.hasValidAdmins, isFalse);
      });

      test('returns true when adminIds is empty', () {
        final community = createCommunity(
          memberIds: ['owner_001'],
          adminIds: [],
        );

        expect(community.hasValidAdmins, isTrue);
      });
    });

    group('ownerIsMember', () {
      test('returns true when owner is in memberIds', () {
        final community = createCommunity(
          ownerId: 'owner_001',
          memberIds: ['owner_001', 'user_001'],
        );

        expect(community.ownerIsMember, isTrue);
      });

      test('returns false when owner is not in memberIds', () {
        final community = createCommunity(
          ownerId: 'owner_001',
          memberIds: ['user_001', 'user_002'],
        );

        expect(community.ownerIsMember, isFalse);
      });
    });

    group('membership helpers', () {
      test('isMember returns true for a member', () {
        final community = createCommunity(
          memberIds: ['owner_001', 'user_001'],
        );

        expect(community.isMember('user_001'), isTrue);
        expect(community.isMember('stranger'), isFalse);
      });

      test('isAdmin returns true for an admin', () {
        final community = createCommunity(
          adminIds: ['owner_001', 'admin_001'],
        );

        expect(community.isAdmin('admin_001'), isTrue);
        expect(community.isAdmin('user_001'), isFalse);
      });

      test('isOwner returns true only for the owner', () {
        final community = createCommunity(ownerId: 'owner_001');

        expect(community.isOwner('owner_001'), isTrue);
        expect(community.isOwner('admin_001'), isFalse);
      });
    });

    group('unread / muted helpers', () {
      test('unreadCountFor returns count for existing user', () {
        final community = createCommunity(
          unreadCounts: {'user_001': 5, 'user_002': 0},
        );

        expect(community.unreadCountFor('user_001'), equals(5));
        expect(community.unreadCountFor('user_002'), equals(0));
      });

      test('unreadCountFor returns 0 for unknown user', () {
        final community = createCommunity(unreadCounts: {});

        expect(community.unreadCountFor('unknown'), equals(0));
      });

      test('hasUnreadFor returns true only when count > 0', () {
        final community = createCommunity(
          unreadCounts: {'user_001': 3, 'user_002': 0},
        );

        expect(community.hasUnreadFor('user_001'), isTrue);
        expect(community.hasUnreadFor('user_002'), isFalse);
        expect(community.hasUnreadFor('unknown'), isFalse);
      });

      test('isMutedFor returns mute status for user', () {
        final community = createCommunity(
          muted: {'user_001': true, 'user_002': false},
        );

        expect(community.isMutedFor('user_001'), isTrue);
        expect(community.isMutedFor('user_002'), isFalse);
        expect(community.isMutedFor('unknown'), isFalse);
      });
    });

    group('tokenBalance / balanceZar', () {
      test('tokenBalance wraps totalBalance as TokenAmount', () {
        final community = createCommunity(totalBalance: 5000);

        expect(community.tokenBalance.value, equals(5000));
      });

      test('balanceZar converts tokens to ZAR (100 tokens = R1)', () {
        final community = createCommunity(totalBalance: 10000);

        expect(community.balanceZar, equals(100.0));
      });

      test('balanceZar handles zero', () {
        final community = createCommunity(totalBalance: 0);

        expect(community.balanceZar, equals(0.0));
      });
    });

    group('displayInitials', () {
      test('returns two initials for two-word name', () {
        final community = createCommunity(name: 'Test Community');

        expect(community.displayInitials, equals('TC'));
      });

      test('returns first two initials for multi-word name', () {
        final community = createCommunity(name: 'My Test Community Group');

        expect(community.displayInitials, equals('MT'));
      });

      test('returns first two characters for single-word name', () {
        final community = createCommunity(name: 'Stokvel');

        expect(community.displayInitials, equals('ST'));
      });

      test('returns single character for one-char name', () {
        final community = createCommunity(name: 'X');

        expect(community.displayInitials, equals('X'));
      });

      test('returns ?? for empty name', () {
        final community = createCommunity(name: '');

        expect(community.displayInitials, equals('??'));
      });
    });
  });

  // ==================== COMMUNITY SETTINGS TESTS ====================

  group('CommunitySettings', () {
    group('isValid', () {
      test('default settings are valid', () {
        const settings = CommunitySettings();

        expect(settings.isValid, isTrue);
      });

      test('valid with all supported contribution cycles', () {
        for (final cycle in ['none', 'weekly', 'monthly', 'yearly']) {
          final settings = CommunitySettings(contributionCycle: cycle);
          expect(settings.isValid, isTrue, reason: 'cycle=$cycle should be valid');
        }
      });

      test('invalid when contributionAmount is negative', () {
        const settings = CommunitySettings(contributionAmount: -1);

        expect(settings.isValid, isFalse);
      });

      test('invalid when penaltyPercentage is negative', () {
        const settings = CommunitySettings(penaltyPercentage: -1);

        expect(settings.isValid, isFalse);
      });

      test('invalid when penaltyPercentage exceeds 100', () {
        const settings = CommunitySettings(penaltyPercentage: 101);

        expect(settings.isValid, isFalse);
      });

      test('valid when penaltyPercentage is exactly 0', () {
        const settings = CommunitySettings(penaltyPercentage: 0);

        expect(settings.isValid, isTrue);
      });

      test('valid when penaltyPercentage is exactly 100', () {
        const settings = CommunitySettings(penaltyPercentage: 100);

        expect(settings.isValid, isTrue);
      });

      test('invalid when maxMembers is less than 1', () {
        const settings = CommunitySettings(maxMembers: 0);

        expect(settings.isValid, isFalse);
      });

      test('valid when maxMembers is exactly 1', () {
        const settings = CommunitySettings(maxMembers: 1);

        expect(settings.isValid, isTrue);
      });

      test('invalid when requireApprovalAbove is negative', () {
        const settings = CommunitySettings(requireApprovalAbove: -1);

        expect(settings.isValid, isFalse);
      });

      test('valid when requireApprovalAbove is zero', () {
        const settings = CommunitySettings(requireApprovalAbove: 0);

        expect(settings.isValid, isTrue);
      });

      test('invalid when contributionCycle is unsupported value', () {
        const settings = CommunitySettings(contributionCycle: 'daily');

        expect(settings.isValid, isFalse);
      });

      test('invalid when contributionCycle is empty string', () {
        const settings = CommunitySettings(contributionCycle: '');

        expect(settings.isValid, isFalse);
      });
    });

    group('defaultFor', () {
      test('regular type returns default settings with no financials', () {
        final settings = CommunitySettings.defaultFor(CommunityType.regular);

        expect(settings.enableFinancials, isFalse);
        expect(settings.maxMembers, equals(100));
        expect(settings.allowMemberInvites, isTrue);
        expect(settings.onlyAdminsPost, isFalse);
        expect(settings.membersCanShareMedia, isTrue);
        expect(settings.contributionCycle, equals('none'));
        expect(settings.contributionAmount, equals(0));
        expect(settings.penaltyPercentage, equals(0));
        expect(settings.isValid, isTrue);
      });

      test('stokvel type returns financial settings enabled', () {
        final settings = CommunitySettings.defaultFor(CommunityType.stokvel);

        expect(settings.enableFinancials, isTrue);
        expect(settings.allowMemberWithdrawals, isFalse);
        expect(settings.contributionCycle, equals('monthly'));
        expect(settings.contributionAmount, equals(1000));
        expect(settings.penaltyPercentage, equals(5));
        expect(settings.requireApprovalAbove, equals(5000));
        expect(settings.isValid, isTrue);
      });

      test('all community types produce valid default settings', () {
        for (final type in CommunityType.values) {
          final settings = CommunitySettings.defaultFor(type);
          expect(settings.isValid, isTrue,
              reason: '${type.name} defaults should be valid');
        }
      });
    });

    group('copyWith', () {
      test('creates a modified copy of settings', () {
        const original = CommunitySettings();
        final modified = original.copyWith(
          maxMembers: 50,
          enableFinancials: true,
        );

        expect(modified.maxMembers, equals(50));
        expect(modified.enableFinancials, isTrue);
        // Unchanged fields remain the same
        expect(modified.allowMemberInvites, equals(original.allowMemberInvites));
        expect(modified.contributionCycle, equals(original.contributionCycle));
      });
    });
  });
}
