import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/community_model.dart';
import 'package:imalichat/domain/entities/community.dart';
import 'package:imalichat/domain/enums/community_status.dart';
import 'package:imalichat/domain/enums/community_type.dart';

void main() {
  group('CommunitySettingsModel', () {
    group('fromJson / toEntity', () {
      test('uses defaults when no fields supplied', () {
        final model = CommunitySettingsModel.fromJson(const <String, dynamic>{});
        final entity = model.toEntity();

        expect(entity.maxMembers, equals(100));
        expect(entity.allowMemberInvites, isTrue);
        expect(entity.onlyAdminsPost, isFalse);
        expect(entity.membersCanShareMedia, isTrue);
        expect(entity.enableFinancials, isFalse);
        expect(entity.requireApprovalAbove, equals(5000));
        expect(entity.allowMemberWithdrawals, isFalse);
        expect(entity.contributionCycle, equals('none'));
        expect(entity.contributionAmount, equals(0));
        expect(entity.penaltyPercentage, equals(0));
      });

      test('parses all fields correctly', () {
        final json = <String, dynamic>{
          'maxMembers': 50,
          'allowMemberInvites': false,
          'onlyAdminsPost': true,
          'membersCanShareMedia': false,
          'enableFinancials': true,
          'requireApprovalAbove': 10000,
          'allowMemberWithdrawals': true,
          'contributionCycle': 'monthly',
          'contributionAmount': 500,
          'penaltyPercentage': 10,
        };

        final model = CommunitySettingsModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.maxMembers, equals(50));
        expect(entity.allowMemberInvites, isFalse);
        expect(entity.onlyAdminsPost, isTrue);
        expect(entity.membersCanShareMedia, isFalse);
        expect(entity.enableFinancials, isTrue);
        expect(entity.requireApprovalAbove, equals(10000));
        expect(entity.allowMemberWithdrawals, isTrue);
        expect(entity.contributionCycle, equals('monthly'));
        expect(entity.contributionAmount, equals(500));
        expect(entity.penaltyPercentage, equals(10));
      });
    });

    group('fromEntity', () {
      test('round-trips through entity and back', () {
        const entity = CommunitySettings(
          maxMembers: 75,
          allowMemberInvites: false,
          onlyAdminsPost: true,
          membersCanShareMedia: false,
          enableFinancials: true,
          requireApprovalAbove: 2000,
          allowMemberWithdrawals: true,
          contributionCycle: 'weekly',
          contributionAmount: 250,
          penaltyPercentage: 3,
        );

        final model = CommunitySettingsModel.fromEntity(entity);
        final restored = model.toEntity();

        expect(restored.maxMembers, equals(entity.maxMembers));
        expect(restored.allowMemberInvites, equals(entity.allowMemberInvites));
        expect(restored.onlyAdminsPost, equals(entity.onlyAdminsPost));
        expect(restored.membersCanShareMedia, equals(entity.membersCanShareMedia));
        expect(restored.enableFinancials, equals(entity.enableFinancials));
        expect(restored.requireApprovalAbove, equals(entity.requireApprovalAbove));
        expect(restored.allowMemberWithdrawals, equals(entity.allowMemberWithdrawals));
        expect(restored.contributionCycle, equals(entity.contributionCycle));
        expect(restored.contributionAmount, equals(entity.contributionAmount));
        expect(restored.penaltyPercentage, equals(entity.penaltyPercentage));
      });
    });
  });

  group('CommunityModel', () {
    final now = DateTime(2025, 1, 15, 10, 30);
    final updatedAt = DateTime(2025, 1, 16, 12, 0);

    /// Creates a complete Firestore-like JSON map for CommunityModel.fromJson.
    Map<String, dynamic> createCompleteJson({
      String status = 'active',
      String type = 'regular',
      Map<String, dynamic>? lastMessageOverrides,
      bool includeLastMessage = true,
      bool includeStokvelSettings = false,
    }) {
      final json = <String, dynamic>{
        'id': 'community_001',
        'type': type,
        'name': 'Test Community',
        'description': 'A community for testing',
        'avatarUrl': 'https://example.com/avatar.png',
        'ownerId': 'user_owner',
        'memberIds': ['user_owner', 'user_2', 'user_3'],
        'adminIds': ['user_owner'],
        'memberCount': 3,
        'totalBalance': 5000,
        'status': status,
        'settings': <String, dynamic>{
          'maxMembers': 200,
          'allowMemberInvites': true,
          'onlyAdminsPost': false,
          'membersCanShareMedia': true,
          'enableFinancials': true,
          'requireApprovalAbove': 10000,
          'allowMemberWithdrawals': false,
          'contributionCycle': 'monthly',
          'contributionAmount': 1000,
          'penaltyPercentage': 5,
        },
        'unreadCounts': <String, dynamic>{
          'user_owner': 0,
          'user_2': 3,
          'user_3': 7,
        },
        'muted': <String, dynamic>{
          'user_owner': false,
          'user_2': true,
        },
        'lastMessageEncryptedPreviews': <String, dynamic>{
          'user_2': 'encrypted_preview_abc',
          'user_3': 'encrypted_preview_def',
        },
        'createdAt': now.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

      if (includeLastMessage) {
        json['lastMessageText'] = 'Hello everyone!';
        json['lastMessageSenderId'] = 'user_2';
        json['lastMessageSenderName'] = 'User Two';
        json['lastMessageType'] = 'text';
        json['lastMessageAt'] = now.toIso8601String();
      }

      if (lastMessageOverrides != null) {
        json.addAll(lastMessageOverrides);
      }

      if (includeStokvelSettings) {
        json['stokvelSettings'] = <String, dynamic>{
          'payoutType': 'rotating',
          'payoutSchedule': 'monthly',
          'currentPayoutRecipient': 'user_2',
          'nextPayoutDate': now.add(const Duration(days: 30)).toIso8601String(),
          'payoutOrder': ['user_owner', 'user_2', 'user_3'],
        };
      }

      return json;
    }

    group('fromJson', () {
      test('parses complete document data correctly', () {
        final json = createCompleteJson();
        final model = CommunityModel.fromJson(json);

        expect(model.id, equals('community_001'));
        expect(model.type, equals('regular'));
        expect(model.name, equals('Test Community'));
        expect(model.description, equals('A community for testing'));
        expect(model.avatarUrl, equals('https://example.com/avatar.png'));
        expect(model.ownerId, equals('user_owner'));
        expect(model.memberIds, equals(['user_owner', 'user_2', 'user_3']));
        expect(model.adminIds, equals(['user_owner']));
        expect(model.memberCount, equals(3));
        expect(model.totalBalance, equals(5000));
        expect(model.status, equals('active'));
      });

      test('parses settings correctly', () {
        final json = createCompleteJson();
        final model = CommunityModel.fromJson(json);

        expect(model.settings.maxMembers, equals(200));
        expect(model.settings.enableFinancials, isTrue);
        expect(model.settings.contributionCycle, equals('monthly'));
        expect(model.settings.contributionAmount, equals(1000));
        expect(model.settings.penaltyPercentage, equals(5));
      });

      test('parses last message fields correctly', () {
        final json = createCompleteJson();
        final model = CommunityModel.fromJson(json);

        expect(model.lastMessageText, equals('Hello everyone!'));
        expect(model.lastMessageSenderId, equals('user_2'));
        expect(model.lastMessageSenderName, equals('User Two'));
        expect(model.lastMessageType, equals('text'));
        expect(model.lastMessageAt, isNotNull);
      });

      test('handles missing last message fields gracefully', () {
        final json = createCompleteJson(includeLastMessage: false);
        final model = CommunityModel.fromJson(json);

        expect(model.lastMessageText, isNull);
        expect(model.lastMessageSenderId, isNull);
        expect(model.lastMessageSenderName, isNull);
        expect(model.lastMessageType, isNull);
        expect(model.lastMessageAt, isNull);
      });

      test('handles partial last message (some fields null)', () {
        final json = createCompleteJson(
          includeLastMessage: false,
          lastMessageOverrides: {
            'lastMessageText': 'Partial message',
            // senderId, senderName, type, and lastMessageAt are missing
          },
        );
        final model = CommunityModel.fromJson(json);

        expect(model.lastMessageText, equals('Partial message'));
        expect(model.lastMessageSenderId, isNull);
        expect(model.lastMessageSenderName, isNull);
        expect(model.lastMessageType, isNull);
        expect(model.lastMessageAt, isNull);
      });

      test('parses per-user maps correctly', () {
        final json = createCompleteJson();
        final model = CommunityModel.fromJson(json);

        expect(model.unreadCounts, equals({'user_owner': 0, 'user_2': 3, 'user_3': 7}));
        expect(model.muted, equals({'user_owner': false, 'user_2': true}));
        expect(
          model.lastMessageEncryptedPreviews,
          equals({
            'user_2': 'encrypted_preview_abc',
            'user_3': 'encrypted_preview_def',
          }),
        );
      });

      test('defaults per-user maps to empty when absent', () {
        final json = createCompleteJson();
        json.remove('unreadCounts');
        json.remove('muted');
        json.remove('lastMessageEncryptedPreviews');

        final model = CommunityModel.fromJson(json);

        expect(model.unreadCounts, isEmpty);
        expect(model.muted, isEmpty);
        expect(model.lastMessageEncryptedPreviews, isEmpty);
      });

      test('parses stokvel settings when present', () {
        final json = createCompleteJson(
          type: 'stokvel',
          includeStokvelSettings: true,
        );
        final model = CommunityModel.fromJson(json);

        expect(model.stokvelSettings, isNotNull);
        expect(model.stokvelSettings!.payoutType, equals('rotating'));
        expect(model.stokvelSettings!.payoutSchedule, equals('monthly'));
        expect(model.stokvelSettings!.currentPayoutRecipient, equals('user_2'));
        expect(model.stokvelSettings!.payoutOrder, equals(['user_owner', 'user_2', 'user_3']));
      });

      test('handles null stokvel settings for regular communities', () {
        final json = createCompleteJson(type: 'regular');
        final model = CommunityModel.fromJson(json);

        expect(model.stokvelSettings, isNull);
      });

      test('defaults totalBalance to 0 when not provided', () {
        final json = createCompleteJson();
        json.remove('totalBalance');
        final model = CommunityModel.fromJson(json);

        expect(model.totalBalance, equals(0));
      });
    });

    group('toEntity', () {
      test('maps all fields correctly to Community entity', () {
        final json = createCompleteJson();
        final model = CommunityModel.fromJson(json);
        final entity = model.toEntity();

        expect(entity.id, equals('community_001'));
        expect(entity.type, equals(CommunityType.regular));
        expect(entity.name, equals('Test Community'));
        expect(entity.description, equals('A community for testing'));
        expect(entity.avatarUrl, equals('https://example.com/avatar.png'));
        expect(entity.ownerId, equals('user_owner'));
        expect(entity.memberIds, equals(['user_owner', 'user_2', 'user_3']));
        expect(entity.adminIds, equals(['user_owner']));
        expect(entity.memberCount, equals(3));
        expect(entity.totalBalance, equals(5000));
        expect(entity.status, equals(CommunityStatus.active));
      });

      test('maps CommunityStatus.active correctly', () {
        final json = createCompleteJson(status: 'active');
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityStatus.active));
        expect(entity.isActive, isTrue);
      });

      test('maps CommunityStatus.suspended correctly', () {
        final json = createCompleteJson(status: 'suspended');
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityStatus.suspended));
        expect(entity.isSuspended, isTrue);
      });

      test('maps CommunityStatus.closed correctly', () {
        final json = createCompleteJson(status: 'closed');
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityStatus.closed));
        expect(entity.isClosed, isTrue);
      });

      test('maps CommunityType.regular correctly', () {
        final json = createCompleteJson(type: 'regular');
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityType.regular));
        expect(entity.isStokvel, isFalse);
      });

      test('maps CommunityType.stokvel correctly', () {
        final json = createCompleteJson(
          type: 'stokvel',
          includeStokvelSettings: true,
        );
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityType.stokvel));
        expect(entity.isStokvel, isTrue);
        expect(entity.stokvelSettings, isNotNull);
      });

      test('defaults unknown status to active with warning', () {
        final json = createCompleteJson(status: 'totally_unknown_status');
        final entity = CommunityModel.fromJson(json).toEntity();

        // Unknown status falls back to active
        expect(entity.status, equals(CommunityStatus.active));
      });

      test('defaults unknown type to regular with warning', () {
        final json = createCompleteJson(type: 'nonexistent_type');
        final entity = CommunityModel.fromJson(json).toEntity();

        // Unknown type falls back to regular
        expect(entity.type, equals(CommunityType.regular));
      });

      test('maps settings entity correctly', () {
        final json = createCompleteJson();
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.settings.maxMembers, equals(200));
        expect(entity.settings.enableFinancials, isTrue);
        expect(entity.settings.contributionCycle, equals('monthly'));
        expect(entity.settings.contributionAmount, equals(1000));
        expect(entity.settings.penaltyPercentage, equals(5));
        expect(entity.settings.allowMemberInvites, isTrue);
        expect(entity.settings.onlyAdminsPost, isFalse);
        expect(entity.settings.membersCanShareMedia, isTrue);
        expect(entity.settings.requireApprovalAbove, equals(10000));
        expect(entity.settings.allowMemberWithdrawals, isFalse);
      });

      test('maps last message fields to entity', () {
        final json = createCompleteJson();
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.lastMessageText, equals('Hello everyone!'));
        expect(entity.lastMessageSenderId, equals('user_2'));
        expect(entity.lastMessageSenderName, equals('User Two'));
        expect(entity.lastMessageType, equals('text'));
        expect(entity.lastMessageAt, isNotNull);
      });

      test('maps per-user maps to entity', () {
        final json = createCompleteJson();
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.unreadCounts, equals({'user_owner': 0, 'user_2': 3, 'user_3': 7}));
        expect(entity.muted, equals({'user_owner': false, 'user_2': true}));
        expect(entity.lastMessageEncryptedPreviews['user_2'], equals('encrypted_preview_abc'));
      });

      test('maps timestamps to entity', () {
        final json = createCompleteJson();
        final entity = CommunityModel.fromJson(json).toEntity();

        expect(entity.createdAt, equals(now));
        expect(entity.updatedAt, equals(updatedAt));
      });
    });

    group('fromEntity', () {
      test('serializes CommunityStatus correctly', () {
        final entity = Community(
          id: 'c1',
          type: CommunityType.regular,
          name: 'Test',
          ownerId: 'owner1',
          memberIds: ['owner1'],
          adminIds: ['owner1'],
          memberCount: 1,
          totalBalance: 0,
          status: CommunityStatus.active,
          settings: const CommunitySettings(),
          unreadCounts: const {},
          muted: const {},
          createdAt: now,
        );

        final model = CommunityModel.fromEntity(entity);
        expect(model.status, equals('active'));
      });

      test('serializes CommunityStatus.suspended correctly', () {
        final entity = Community(
          id: 'c1',
          type: CommunityType.regular,
          name: 'Test',
          ownerId: 'owner1',
          memberIds: ['owner1'],
          adminIds: ['owner1'],
          memberCount: 1,
          totalBalance: 0,
          status: CommunityStatus.suspended,
          settings: const CommunitySettings(),
          unreadCounts: const {},
          muted: const {},
          createdAt: now,
        );

        final model = CommunityModel.fromEntity(entity);
        expect(model.status, equals('suspended'));
      });

      test('serializes CommunityStatus.closed correctly', () {
        final entity = Community(
          id: 'c1',
          type: CommunityType.regular,
          name: 'Test',
          ownerId: 'owner1',
          memberIds: ['owner1'],
          adminIds: ['owner1'],
          memberCount: 1,
          totalBalance: 0,
          status: CommunityStatus.closed,
          settings: const CommunitySettings(),
          unreadCounts: const {},
          muted: const {},
          createdAt: now,
        );

        final model = CommunityModel.fromEntity(entity);
        expect(model.status, equals('closed'));
      });

      test('serializes CommunityType correctly', () {
        final regularEntity = Community(
          id: 'c1',
          type: CommunityType.regular,
          name: 'Regular',
          ownerId: 'o1',
          memberIds: ['o1'],
          adminIds: ['o1'],
          memberCount: 1,
          totalBalance: 0,
          status: CommunityStatus.active,
          settings: const CommunitySettings(),
          unreadCounts: const {},
          muted: const {},
          createdAt: now,
        );
        final stokvelEntity = regularEntity.copyWith(
          type: CommunityType.stokvel,
          name: 'Stokvel',
        );

        expect(CommunityModel.fromEntity(regularEntity).type, equals('regular'));
        expect(CommunityModel.fromEntity(stokvelEntity).type, equals('stokvel'));
      });

      test('serializes all fields from entity', () {
        final entity = Community(
          id: 'community_full',
          type: CommunityType.stokvel,
          name: 'Full Community',
          description: 'Full description',
          avatarUrl: 'https://example.com/img.png',
          ownerId: 'user_owner',
          memberIds: ['user_owner', 'user_2'],
          adminIds: ['user_owner'],
          memberCount: 2,
          totalBalance: 7500,
          status: CommunityStatus.active,
          settings: const CommunitySettings(
            maxMembers: 50,
            enableFinancials: true,
            contributionCycle: 'weekly',
            contributionAmount: 200,
          ),
          lastMessageText: 'Last msg',
          lastMessageSenderId: 'user_2',
          lastMessageSenderName: 'User 2',
          lastMessageType: 'text',
          lastMessageAt: now,
          unreadCounts: {'user_owner': 1, 'user_2': 0},
          muted: {'user_owner': false, 'user_2': true},
          lastMessageEncryptedPreviews: {'user_owner': 'enc_preview'},
          createdAt: now,
          updatedAt: updatedAt,
        );

        final model = CommunityModel.fromEntity(entity);

        expect(model.id, equals('community_full'));
        expect(model.type, equals('stokvel'));
        expect(model.name, equals('Full Community'));
        expect(model.description, equals('Full description'));
        expect(model.avatarUrl, equals('https://example.com/img.png'));
        expect(model.ownerId, equals('user_owner'));
        expect(model.memberIds, equals(['user_owner', 'user_2']));
        expect(model.adminIds, equals(['user_owner']));
        expect(model.memberCount, equals(2));
        expect(model.totalBalance, equals(7500));
        expect(model.status, equals('active'));
        expect(model.settings.maxMembers, equals(50));
        expect(model.settings.enableFinancials, isTrue);
        expect(model.lastMessageText, equals('Last msg'));
        expect(model.lastMessageSenderId, equals('user_2'));
        expect(model.lastMessageSenderName, equals('User 2'));
        expect(model.lastMessageType, equals('text'));
        expect(model.lastMessageAt, equals(now));
        expect(model.unreadCounts, equals({'user_owner': 1, 'user_2': 0}));
        expect(model.muted, equals({'user_owner': false, 'user_2': true}));
        expect(model.lastMessageEncryptedPreviews, equals({'user_owner': 'enc_preview'}));
        expect(model.createdAt, equals(now));
        expect(model.updatedAt, equals(updatedAt));
      });
    });

    group('roundtrip', () {
      test('entity -> model -> entity preserves all data', () {
        final entity = Community(
          id: 'roundtrip_001',
          type: CommunityType.regular,
          name: 'Roundtrip Community',
          description: 'Testing roundtrip',
          avatarUrl: 'https://example.com/rt.png',
          ownerId: 'owner_rt',
          memberIds: ['owner_rt', 'member_rt'],
          adminIds: ['owner_rt'],
          memberCount: 2,
          totalBalance: 3000,
          status: CommunityStatus.active,
          settings: const CommunitySettings(
            maxMembers: 150,
            allowMemberInvites: false,
            onlyAdminsPost: true,
            membersCanShareMedia: false,
            enableFinancials: true,
            requireApprovalAbove: 8000,
            allowMemberWithdrawals: true,
            contributionCycle: 'weekly',
            contributionAmount: 300,
            penaltyPercentage: 7,
          ),
          lastMessageText: 'Roundtrip msg',
          lastMessageSenderId: 'member_rt',
          lastMessageSenderName: 'Member RT',
          lastMessageType: 'image',
          lastMessageAt: now,
          unreadCounts: {'owner_rt': 2, 'member_rt': 0},
          muted: {'owner_rt': false, 'member_rt': true},
          lastMessageEncryptedPreviews: {'owner_rt': 'enc_rt'},
          createdAt: now,
          updatedAt: updatedAt,
        );

        final model = CommunityModel.fromEntity(entity);
        final restored = model.toEntity();

        expect(restored.id, equals(entity.id));
        expect(restored.type, equals(entity.type));
        expect(restored.name, equals(entity.name));
        expect(restored.description, equals(entity.description));
        expect(restored.avatarUrl, equals(entity.avatarUrl));
        expect(restored.ownerId, equals(entity.ownerId));
        expect(restored.memberIds, equals(entity.memberIds));
        expect(restored.adminIds, equals(entity.adminIds));
        expect(restored.memberCount, equals(entity.memberCount));
        expect(restored.totalBalance, equals(entity.totalBalance));
        expect(restored.status, equals(entity.status));
        expect(restored.settings.maxMembers, equals(entity.settings.maxMembers));
        expect(restored.settings.allowMemberInvites, equals(entity.settings.allowMemberInvites));
        expect(restored.settings.onlyAdminsPost, equals(entity.settings.onlyAdminsPost));
        expect(restored.settings.enableFinancials, equals(entity.settings.enableFinancials));
        expect(restored.settings.contributionCycle, equals(entity.settings.contributionCycle));
        expect(restored.settings.contributionAmount, equals(entity.settings.contributionAmount));
        expect(restored.settings.penaltyPercentage, equals(entity.settings.penaltyPercentage));
        expect(restored.lastMessageText, equals(entity.lastMessageText));
        expect(restored.lastMessageSenderId, equals(entity.lastMessageSenderId));
        expect(restored.lastMessageSenderName, equals(entity.lastMessageSenderName));
        expect(restored.lastMessageType, equals(entity.lastMessageType));
        expect(restored.lastMessageAt, equals(entity.lastMessageAt));
        expect(restored.unreadCounts, equals(entity.unreadCounts));
        expect(restored.muted, equals(entity.muted));
        expect(restored.lastMessageEncryptedPreviews, equals(entity.lastMessageEncryptedPreviews));
        expect(restored.createdAt, equals(entity.createdAt));
        expect(restored.updatedAt, equals(entity.updatedAt));
      });

      test('json -> model -> entity -> model -> json round-trip', () {
        final json = createCompleteJson();
        final model1 = CommunityModel.fromJson(json);
        final entity = model1.toEntity();
        final model2 = CommunityModel.fromEntity(entity);

        expect(model2.id, equals(model1.id));
        expect(model2.type, equals(model1.type));
        expect(model2.name, equals(model1.name));
        expect(model2.description, equals(model1.description));
        expect(model2.ownerId, equals(model1.ownerId));
        expect(model2.memberIds, equals(model1.memberIds));
        expect(model2.adminIds, equals(model1.adminIds));
        expect(model2.memberCount, equals(model1.memberCount));
        expect(model2.totalBalance, equals(model1.totalBalance));
        expect(model2.status, equals(model1.status));
        expect(model2.lastMessageText, equals(model1.lastMessageText));
        expect(model2.lastMessageSenderId, equals(model1.lastMessageSenderId));
        expect(model2.unreadCounts, equals(model1.unreadCounts));
        expect(model2.muted, equals(model1.muted));
      });
    });

    group('equality', () {
      test('two models with same values are equal (Freezed)', () {
        final model1 = CommunityModel(
          id: 'eq_001',
          type: 'regular',
          name: 'EQ',
          ownerId: 'o1',
          memberIds: const ['o1'],
          adminIds: const ['o1'],
          memberCount: 1,
          status: 'active',
          settings: const CommunitySettingsModel(),
          createdAt: now,
        );
        final model2 = CommunityModel(
          id: 'eq_001',
          type: 'regular',
          name: 'EQ',
          ownerId: 'o1',
          memberIds: const ['o1'],
          adminIds: const ['o1'],
          memberCount: 1,
          status: 'active',
          settings: const CommunitySettingsModel(),
          createdAt: now,
        );

        expect(model1, equals(model2));
      });

      test('two models with different ids are not equal', () {
        final model1 = CommunityModel(
          id: 'eq_001',
          type: 'regular',
          name: 'EQ',
          ownerId: 'o1',
          memberIds: const ['o1'],
          adminIds: const ['o1'],
          memberCount: 1,
          status: 'active',
          settings: const CommunitySettingsModel(),
          createdAt: now,
        );
        final model2 = CommunityModel(
          id: 'eq_002',
          type: 'regular',
          name: 'EQ',
          ownerId: 'o1',
          memberIds: const ['o1'],
          adminIds: const ['o1'],
          memberCount: 1,
          status: 'active',
          settings: const CommunitySettingsModel(),
          createdAt: now,
        );

        expect(model1, isNot(equals(model2)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated fields', () {
        final model = CommunityModel(
          id: 'cw_001',
          type: 'regular',
          name: 'Original',
          ownerId: 'o1',
          memberIds: const ['o1'],
          adminIds: const ['o1'],
          memberCount: 1,
          status: 'active',
          settings: const CommunitySettingsModel(),
          createdAt: now,
        );

        final updated = model.copyWith(
          name: 'Updated',
          status: 'suspended',
          memberCount: 5,
        );

        expect(updated.name, equals('Updated'));
        expect(updated.status, equals('suspended'));
        expect(updated.memberCount, equals(5));
        // Unchanged fields preserved
        expect(updated.id, equals('cw_001'));
        expect(updated.type, equals('regular'));
        expect(updated.ownerId, equals('o1'));
      });
    });
  });
}
