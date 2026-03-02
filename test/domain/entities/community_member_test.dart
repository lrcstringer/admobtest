import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/community_member.dart';
import 'package:imalichat/domain/enums/member_role.dart';
import 'package:imalichat/domain/enums/member_status.dart';

void main() {
  // ==================== HELPERS ====================

  CommunityMember createMember({
    String id = 'member_001',
    String communityId = 'community_001',
    String userId = 'user_001',
    String displayName = 'Test User',
    String? avatarUrl,
    MemberRole role = MemberRole.member,
    MemberStatus status = MemberStatus.active,
    int contributionBalance = 0,
    DateTime? joinedAt,
    String invitedBy = 'owner_001',
    DateTime? invitedAt,
    DateTime? lastReadAt,
    String? communityName,
  }) {
    return CommunityMember(
      id: id,
      communityId: communityId,
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      role: role,
      status: status,
      contributionBalance: contributionBalance,
      joinedAt: joinedAt,
      invitedBy: invitedBy,
      invitedAt: invitedAt ?? DateTime(2024, 6, 1),
      lastReadAt: lastReadAt,
      communityName: communityName,
    );
  }

  // ==================== TESTS ====================

  group('CommunityMember', () {
    group('entity creation', () {
      test('creates a valid member with required fields', () {
        final member = createMember();

        expect(member.id, equals('member_001'));
        expect(member.communityId, equals('community_001'));
        expect(member.userId, equals('user_001'));
        expect(member.displayName, equals('Test User'));
        expect(member.role, equals(MemberRole.member));
        expect(member.status, equals(MemberStatus.active));
        expect(member.contributionBalance, equals(0));
        expect(member.invitedBy, equals('owner_001'));
      });

      test('copyWith creates a modified copy', () {
        final original = createMember();
        final modified = original.copyWith(
          role: MemberRole.admin,
          status: MemberStatus.blocked,
        );

        expect(modified.role, equals(MemberRole.admin));
        expect(modified.status, equals(MemberStatus.blocked));
        expect(modified.id, equals(original.id));
        expect(modified.userId, equals(original.userId));
      });

      test('optional fields default correctly', () {
        final member = createMember(
          avatarUrl: null,
          joinedAt: null,
          lastReadAt: null,
          communityName: null,
        );

        expect(member.avatarUrl, isNull);
        expect(member.joinedAt, isNull);
        expect(member.lastReadAt, isNull);
        expect(member.communityName, isNull);
      });

      test('contributionBalance defaults to 0', () {
        final member = createMember();

        expect(member.contributionBalance, equals(0));
      });
    });

    group('tokenContribution', () {
      test('wraps contributionBalance as TokenAmount', () {
        final member = createMember(contributionBalance: 5000);

        expect(member.tokenContribution.value, equals(5000));
      });

      test('handles zero balance', () {
        final member = createMember(contributionBalance: 0);

        expect(member.tokenContribution.value, equals(0));
      });
    });

    group('isActive / isInvited / isBlocked', () {
      test('isActive is true only for active status', () {
        expect(createMember(status: MemberStatus.active).isActive, isTrue);
        expect(createMember(status: MemberStatus.invited).isActive, isFalse);
        expect(createMember(status: MemberStatus.blocked).isActive, isFalse);
      });

      test('isInvited is true only for invited status', () {
        expect(createMember(status: MemberStatus.invited).isInvited, isTrue);
        expect(createMember(status: MemberStatus.active).isInvited, isFalse);
        expect(createMember(status: MemberStatus.blocked).isInvited, isFalse);
      });

      test('isBlocked is true only for blocked status', () {
        expect(createMember(status: MemberStatus.blocked).isBlocked, isTrue);
        expect(createMember(status: MemberStatus.active).isBlocked, isFalse);
        expect(createMember(status: MemberStatus.invited).isBlocked, isFalse);
      });
    });

    group('isOwner', () {
      test('returns true only for owner role', () {
        expect(createMember(role: MemberRole.owner).isOwner, isTrue);
        expect(createMember(role: MemberRole.admin).isOwner, isFalse);
        expect(createMember(role: MemberRole.treasurer).isOwner, isFalse);
        expect(createMember(role: MemberRole.member).isOwner, isFalse);
        expect(createMember(role: MemberRole.viewer).isOwner, isFalse);
      });
    });

    group('isAdmin', () {
      test('returns true for owner and admin roles', () {
        expect(createMember(role: MemberRole.owner).isAdmin, isTrue);
        expect(createMember(role: MemberRole.admin).isAdmin, isTrue);
        expect(createMember(role: MemberRole.treasurer).isAdmin, isFalse);
        expect(createMember(role: MemberRole.member).isAdmin, isFalse);
        expect(createMember(role: MemberRole.viewer).isAdmin, isFalse);
      });
    });

    group('canManageMembers', () {
      test('returns true for owner and admin', () {
        expect(createMember(role: MemberRole.owner).canManageMembers, isTrue);
        expect(createMember(role: MemberRole.admin).canManageMembers, isTrue);
      });

      test('returns false for treasurer, member, viewer', () {
        expect(
            createMember(role: MemberRole.treasurer).canManageMembers, isFalse);
        expect(
            createMember(role: MemberRole.member).canManageMembers, isFalse);
        expect(
            createMember(role: MemberRole.viewer).canManageMembers, isFalse);
      });
    });

    group('canApproveFunds', () {
      test('returns true for owner, admin, and treasurer', () {
        expect(createMember(role: MemberRole.owner).canApproveFunds, isTrue);
        expect(createMember(role: MemberRole.admin).canApproveFunds, isTrue);
        expect(
            createMember(role: MemberRole.treasurer).canApproveFunds, isTrue);
      });

      test('returns false for member and viewer', () {
        expect(createMember(role: MemberRole.member).canApproveFunds, isFalse);
        expect(createMember(role: MemberRole.viewer).canApproveFunds, isFalse);
      });
    });

    group('canTransferFunds', () {
      test('returns true for all roles except viewer', () {
        expect(createMember(role: MemberRole.owner).canTransferFunds, isTrue);
        expect(createMember(role: MemberRole.admin).canTransferFunds, isTrue);
        expect(
            createMember(role: MemberRole.treasurer).canTransferFunds, isTrue);
        expect(createMember(role: MemberRole.member).canTransferFunds, isTrue);
      });

      test('returns false for viewer', () {
        expect(createMember(role: MemberRole.viewer).canTransferFunds, isFalse);
      });
    });

    group('canViewLedger', () {
      test('returns true for all roles except viewer', () {
        expect(createMember(role: MemberRole.owner).canViewLedger, isTrue);
        expect(createMember(role: MemberRole.admin).canViewLedger, isTrue);
        expect(createMember(role: MemberRole.treasurer).canViewLedger, isTrue);
        expect(createMember(role: MemberRole.member).canViewLedger, isTrue);
      });

      test('returns false for viewer', () {
        expect(createMember(role: MemberRole.viewer).canViewLedger, isFalse);
      });
    });

    group('canEditSettings', () {
      test('returns true for owner and admin', () {
        expect(createMember(role: MemberRole.owner).canEditSettings, isTrue);
        expect(createMember(role: MemberRole.admin).canEditSettings, isTrue);
      });

      test('returns false for treasurer, member, viewer', () {
        expect(
            createMember(role: MemberRole.treasurer).canEditSettings, isFalse);
        expect(createMember(role: MemberRole.member).canEditSettings, isFalse);
        expect(createMember(role: MemberRole.viewer).canEditSettings, isFalse);
      });
    });

    group('roleDisplayName', () {
      test('returns correct display name for each role', () {
        expect(
            createMember(role: MemberRole.owner).roleDisplayName, equals('Owner'));
        expect(
            createMember(role: MemberRole.admin).roleDisplayName, equals('Admin'));
        expect(createMember(role: MemberRole.treasurer).roleDisplayName,
            equals('Treasurer'));
        expect(createMember(role: MemberRole.member).roleDisplayName,
            equals('Member'));
        expect(createMember(role: MemberRole.viewer).roleDisplayName,
            equals('Viewer'));
      });
    });

    group('statusDisplayName', () {
      test('returns correct display name for each status', () {
        expect(createMember(status: MemberStatus.active).statusDisplayName,
            equals('Active'));
        expect(createMember(status: MemberStatus.invited).statusDisplayName,
            equals('Invited'));
        expect(createMember(status: MemberStatus.blocked).statusDisplayName,
            equals('Blocked'));
      });
    });

    group('all roles have consistent permissions hierarchy', () {
      test('owner has all permissions', () {
        final owner = createMember(role: MemberRole.owner);

        expect(owner.isOwner, isTrue);
        expect(owner.isAdmin, isTrue);
        expect(owner.canManageMembers, isTrue);
        expect(owner.canApproveFunds, isTrue);
        expect(owner.canTransferFunds, isTrue);
        expect(owner.canViewLedger, isTrue);
        expect(owner.canEditSettings, isTrue);
      });

      test('admin has all permissions except isOwner', () {
        final admin = createMember(role: MemberRole.admin);

        expect(admin.isOwner, isFalse);
        expect(admin.isAdmin, isTrue);
        expect(admin.canManageMembers, isTrue);
        expect(admin.canApproveFunds, isTrue);
        expect(admin.canTransferFunds, isTrue);
        expect(admin.canViewLedger, isTrue);
        expect(admin.canEditSettings, isTrue);
      });

      test('treasurer can approve/transfer/view but not manage members or edit settings',
          () {
        final treasurer = createMember(role: MemberRole.treasurer);

        expect(treasurer.isOwner, isFalse);
        expect(treasurer.isAdmin, isFalse);
        expect(treasurer.canManageMembers, isFalse);
        expect(treasurer.canApproveFunds, isTrue);
        expect(treasurer.canTransferFunds, isTrue);
        expect(treasurer.canViewLedger, isTrue);
        expect(treasurer.canEditSettings, isFalse);
      });

      test('member can transfer and view but nothing else', () {
        final member = createMember(role: MemberRole.member);

        expect(member.isOwner, isFalse);
        expect(member.isAdmin, isFalse);
        expect(member.canManageMembers, isFalse);
        expect(member.canApproveFunds, isFalse);
        expect(member.canTransferFunds, isTrue);
        expect(member.canViewLedger, isTrue);
        expect(member.canEditSettings, isFalse);
      });

      test('viewer has no permissions', () {
        final viewer = createMember(role: MemberRole.viewer);

        expect(viewer.isOwner, isFalse);
        expect(viewer.isAdmin, isFalse);
        expect(viewer.canManageMembers, isFalse);
        expect(viewer.canApproveFunds, isFalse);
        expect(viewer.canTransferFunds, isFalse);
        expect(viewer.canViewLedger, isFalse);
        expect(viewer.canEditSettings, isFalse);
      });
    });
  });
}
