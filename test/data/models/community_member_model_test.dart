import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/community_member_model.dart';
import 'package:imalichat/domain/entities/community_member.dart';
import 'package:imalichat/domain/enums/member_role.dart';
import 'package:imalichat/domain/enums/member_status.dart';

void main() {
  group('CommunityMemberModel', () {
    final invitedAt = DateTime(2025, 1, 10, 9, 0);
    final joinedAt = DateTime(2025, 1, 11, 14, 30);
    final lastReadAt = DateTime(2025, 1, 15, 18, 0);

    /// Creates a complete JSON map for CommunityMemberModel.fromJson.
    Map<String, dynamic> createValidJson({
      String role = 'member',
      String status = 'active',
      bool includeOptionals = true,
    }) {
      final json = <String, dynamic>{
        'id': 'member_001',
        'communityId': 'community_001',
        'userId': 'user_001',
        'displayName': 'Test User',
        'role': role,
        'status': status,
        'contributionBalance': 2500,
        'invitedBy': 'user_owner',
        'invitedAt': invitedAt.toIso8601String(),
      };

      if (includeOptionals) {
        json['avatarUrl'] = 'https://example.com/avatar.png';
        json['joinedAt'] = joinedAt.toIso8601String();
        json['lastReadAt'] = lastReadAt.toIso8601String();
        json['communityName'] = 'Test Community';
      }

      return json;
    }

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createValidJson();
        final model = CommunityMemberModel.fromJson(json);

        expect(model.id, equals('member_001'));
        expect(model.communityId, equals('community_001'));
        expect(model.userId, equals('user_001'));
        expect(model.displayName, equals('Test User'));
        expect(model.avatarUrl, equals('https://example.com/avatar.png'));
        expect(model.role, equals('member'));
        expect(model.status, equals('active'));
        expect(model.contributionBalance, equals(2500));
        expect(model.invitedBy, equals('user_owner'));
        expect(model.invitedAt, equals(invitedAt));
        expect(model.joinedAt, equals(joinedAt));
        expect(model.lastReadAt, equals(lastReadAt));
        expect(model.communityName, equals('Test Community'));
      });

      test('handles missing optional fields', () {
        final json = createValidJson(includeOptionals: false);
        final model = CommunityMemberModel.fromJson(json);

        expect(model.avatarUrl, isNull);
        expect(model.joinedAt, isNull);
        expect(model.lastReadAt, isNull);
        expect(model.communityName, isNull);
      });

      test('defaults contributionBalance to 0 when missing', () {
        final json = createValidJson();
        json.remove('contributionBalance');
        final model = CommunityMemberModel.fromJson(json);

        expect(model.contributionBalance, equals(0));
      });
    });

    group('toEntity', () {
      test('maps all fields correctly with valid role and status', () {
        final json = createValidJson(role: 'admin', status: 'active');
        final model = CommunityMemberModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.id, equals('member_001'));
        expect(entity.communityId, equals('community_001'));
        expect(entity.userId, equals('user_001'));
        expect(entity.displayName, equals('Test User'));
        expect(entity.avatarUrl, equals('https://example.com/avatar.png'));
        expect(entity.role, equals(MemberRole.admin));
        expect(entity.status, equals(MemberStatus.active));
        expect(entity.contributionBalance, equals(2500));
        expect(entity.invitedBy, equals('user_owner'));
        expect(entity.invitedAt, equals(invitedAt));
        expect(entity.joinedAt, equals(joinedAt));
        expect(entity.lastReadAt, equals(lastReadAt));
        expect(entity.communityName, equals('Test Community'));
      });

      test('maps MemberRole.owner correctly', () {
        final json = createValidJson(role: 'owner');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.role, equals(MemberRole.owner));
        expect(entity.isOwner, isTrue);
      });

      test('maps MemberRole.admin correctly', () {
        final json = createValidJson(role: 'admin');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.role, equals(MemberRole.admin));
        expect(entity.isAdmin, isTrue);
      });

      test('maps MemberRole.treasurer correctly', () {
        final json = createValidJson(role: 'treasurer');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.role, equals(MemberRole.treasurer));
        expect(entity.canApproveFunds, isTrue);
      });

      test('maps MemberRole.member correctly', () {
        final json = createValidJson(role: 'member');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.role, equals(MemberRole.member));
      });

      test('maps MemberRole.viewer correctly', () {
        final json = createValidJson(role: 'viewer');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.role, equals(MemberRole.viewer));
      });

      test('defaults unknown role to member with warning', () {
        final json = createValidJson(role: 'superadmin_nonexistent');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        // Unknown role defaults to member
        expect(entity.role, equals(MemberRole.member));
      });

      test('maps MemberStatus.active correctly', () {
        final json = createValidJson(status: 'active');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.status, equals(MemberStatus.active));
        expect(entity.isActive, isTrue);
      });

      test('maps MemberStatus.invited correctly', () {
        final json = createValidJson(status: 'invited');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.status, equals(MemberStatus.invited));
        expect(entity.isInvited, isTrue);
      });

      test('maps MemberStatus.blocked correctly', () {
        final json = createValidJson(status: 'blocked');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.status, equals(MemberStatus.blocked));
        expect(entity.isBlocked, isTrue);
      });

      test('defaults unknown status to invited with warning', () {
        final json = createValidJson(status: 'deactivated_nonexistent');
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        // Unknown status defaults to invited
        expect(entity.status, equals(MemberStatus.invited));
      });

      test('handles null optional date fields', () {
        final json = createValidJson(includeOptionals: false);
        final entity = CommunityMemberModel.fromJson(json).toEntity();

        expect(entity.joinedAt, isNull);
        expect(entity.lastReadAt, isNull);
        expect(entity.avatarUrl, isNull);
        expect(entity.communityName, isNull);
      });
    });

    group('fromEntity', () {
      test('serializes all fields from entity', () {
        final entity = CommunityMember(
          id: 'member_fe',
          communityId: 'community_fe',
          userId: 'user_fe',
          displayName: 'From Entity User',
          avatarUrl: 'https://example.com/fe.png',
          role: MemberRole.treasurer,
          status: MemberStatus.active,
          contributionBalance: 4200,
          joinedAt: joinedAt,
          invitedBy: 'user_inviter',
          invitedAt: invitedAt,
          lastReadAt: lastReadAt,
          communityName: 'From Entity Community',
        );

        final model = CommunityMemberModel.fromEntity(entity);

        expect(model.id, equals('member_fe'));
        expect(model.communityId, equals('community_fe'));
        expect(model.userId, equals('user_fe'));
        expect(model.displayName, equals('From Entity User'));
        expect(model.avatarUrl, equals('https://example.com/fe.png'));
        expect(model.role, equals('treasurer'));
        expect(model.status, equals('active'));
        expect(model.contributionBalance, equals(4200));
        expect(model.joinedAt, equals(joinedAt));
        expect(model.invitedBy, equals('user_inviter'));
        expect(model.invitedAt, equals(invitedAt));
        expect(model.lastReadAt, equals(lastReadAt));
        expect(model.communityName, equals('From Entity Community'));
      });

      test('serializes each MemberRole to its string name', () {
        CommunityMemberModel makeModel(MemberRole role) {
          return CommunityMemberModel.fromEntity(CommunityMember(
            id: 'id',
            communityId: 'cid',
            userId: 'uid',
            displayName: 'Name',
            role: role,
            status: MemberStatus.active,
            invitedBy: 'inv',
            invitedAt: invitedAt,
          ));
        }

        expect(makeModel(MemberRole.owner).role, equals('owner'));
        expect(makeModel(MemberRole.admin).role, equals('admin'));
        expect(makeModel(MemberRole.treasurer).role, equals('treasurer'));
        expect(makeModel(MemberRole.member).role, equals('member'));
        expect(makeModel(MemberRole.viewer).role, equals('viewer'));
      });

      test('serializes each MemberStatus to its string name', () {
        CommunityMemberModel makeModel(MemberStatus status) {
          return CommunityMemberModel.fromEntity(CommunityMember(
            id: 'id',
            communityId: 'cid',
            userId: 'uid',
            displayName: 'Name',
            role: MemberRole.member,
            status: status,
            invitedBy: 'inv',
            invitedAt: invitedAt,
          ));
        }

        expect(makeModel(MemberStatus.active).status, equals('active'));
        expect(makeModel(MemberStatus.invited).status, equals('invited'));
        expect(makeModel(MemberStatus.blocked).status, equals('blocked'));
      });

      test('handles null optional fields from entity', () {
        final entity = CommunityMember(
          id: 'member_null',
          communityId: 'community_null',
          userId: 'user_null',
          displayName: 'Null User',
          role: MemberRole.member,
          status: MemberStatus.invited,
          invitedBy: 'user_inviter',
          invitedAt: invitedAt,
          // avatarUrl, joinedAt, lastReadAt, communityName all null
        );

        final model = CommunityMemberModel.fromEntity(entity);

        expect(model.avatarUrl, isNull);
        expect(model.joinedAt, isNull);
        expect(model.lastReadAt, isNull);
        expect(model.communityName, isNull);
        expect(model.contributionBalance, equals(0));
      });
    });

    group('roundtrip', () {
      test('entity -> model -> entity preserves all data', () {
        final entity = CommunityMember(
          id: 'rt_001',
          communityId: 'community_rt',
          userId: 'user_rt',
          displayName: 'Roundtrip User',
          avatarUrl: 'https://example.com/rt.png',
          role: MemberRole.admin,
          status: MemberStatus.active,
          contributionBalance: 9999,
          joinedAt: joinedAt,
          invitedBy: 'user_inviter_rt',
          invitedAt: invitedAt,
          lastReadAt: lastReadAt,
          communityName: 'Roundtrip Community',
        );

        final model = CommunityMemberModel.fromEntity(entity);
        final restored = model.toEntity();

        expect(restored.id, equals(entity.id));
        expect(restored.communityId, equals(entity.communityId));
        expect(restored.userId, equals(entity.userId));
        expect(restored.displayName, equals(entity.displayName));
        expect(restored.avatarUrl, equals(entity.avatarUrl));
        expect(restored.role, equals(entity.role));
        expect(restored.status, equals(entity.status));
        expect(restored.contributionBalance, equals(entity.contributionBalance));
        expect(restored.joinedAt, equals(entity.joinedAt));
        expect(restored.invitedBy, equals(entity.invitedBy));
        expect(restored.invitedAt, equals(entity.invitedAt));
        expect(restored.lastReadAt, equals(entity.lastReadAt));
        expect(restored.communityName, equals(entity.communityName));
      });

      test('json -> model -> entity -> model preserves role and status', () {
        for (final role in ['owner', 'admin', 'treasurer', 'member', 'viewer']) {
          for (final status in ['active', 'invited', 'blocked']) {
            final json = createValidJson(role: role, status: status);
            final model1 = CommunityMemberModel.fromJson(json);
            final entity = model1.toEntity();
            final model2 = CommunityMemberModel.fromEntity(entity);

            expect(model2.role, equals(role),
                reason: 'Role "$role" should roundtrip correctly');
            expect(model2.status, equals(status),
                reason: 'Status "$status" should roundtrip correctly');
          }
        }
      });
    });

    group('equality', () {
      test('two models with same values are equal', () {
        final model1 = CommunityMemberModel(
          id: 'eq_001',
          communityId: 'c1',
          userId: 'u1',
          displayName: 'User',
          role: 'member',
          status: 'active',
          invitedBy: 'inv',
          invitedAt: invitedAt,
        );
        final model2 = CommunityMemberModel(
          id: 'eq_001',
          communityId: 'c1',
          userId: 'u1',
          displayName: 'User',
          role: 'member',
          status: 'active',
          invitedBy: 'inv',
          invitedAt: invitedAt,
        );

        expect(model1, equals(model2));
      });

      test('two models with different ids are not equal', () {
        final model1 = CommunityMemberModel(
          id: 'eq_001',
          communityId: 'c1',
          userId: 'u1',
          displayName: 'User',
          role: 'member',
          status: 'active',
          invitedBy: 'inv',
          invitedAt: invitedAt,
        );
        final model2 = CommunityMemberModel(
          id: 'eq_002',
          communityId: 'c1',
          userId: 'u1',
          displayName: 'User',
          role: 'member',
          status: 'active',
          invitedBy: 'inv',
          invitedAt: invitedAt,
        );

        expect(model1, isNot(equals(model2)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated fields', () {
        final original = CommunityMemberModel(
          id: 'cw_001',
          communityId: 'c1',
          userId: 'u1',
          displayName: 'Original User',
          role: 'member',
          status: 'invited',
          invitedBy: 'inv',
          invitedAt: invitedAt,
        );

        final updated = original.copyWith(
          displayName: 'Updated User',
          role: 'admin',
          status: 'active',
          contributionBalance: 5000,
        );

        expect(updated.displayName, equals('Updated User'));
        expect(updated.role, equals('admin'));
        expect(updated.status, equals('active'));
        expect(updated.contributionBalance, equals(5000));
        // Unchanged fields preserved
        expect(updated.id, equals('cw_001'));
        expect(updated.communityId, equals('c1'));
        expect(updated.userId, equals('u1'));
        expect(updated.invitedBy, equals('inv'));
      });
    });
  });
}
