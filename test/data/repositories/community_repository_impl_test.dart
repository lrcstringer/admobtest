import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/core/services/offline_action_queue.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/data/datasources/remote/community_remote_datasource.dart';
import 'package:imalichat/core/services/community_sync_service.dart';
import 'package:imalichat/core/services/sender_key_service.dart';
import 'package:imalichat/data/datasources/remote/media_upload_datasource.dart';
import 'package:imalichat/data/models/community_model.dart';
import 'package:imalichat/data/repositories/community_repository_impl.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/enums/community_type.dart';
import 'package:imalichat/domain/enums/member_role.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:imalichat/domain/repositories/community_repository.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockCommunityRemoteDataSource extends Mock
    implements CommunityRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockOfflineActionQueue extends Mock implements OfflineActionQueue {}

class MockOutgoingMessageQueue extends Mock implements OutgoingMessageQueue {}

class MockMediaUploadDatasource extends Mock implements MediaUploadDatasource {}

class MockCommunitySyncService extends Mock implements CommunitySyncService {}

class MockSenderKeyService extends Mock implements SenderKeyService {}

// ==================== FALLBACK VALUES ====================

class FakeCreateCommunityParams extends Fake
    implements CreateCommunityParams {}

class FakeUpdateCommunityParams extends Fake
    implements UpdateCommunityParams {}

class FakeLocalCommunitiesCompanion extends Fake
    implements LocalCommunitiesCompanion {}

// ==================== TEST FIXTURES ====================

const _userId = 'user_1';
const _communityId = 'community_123';

CommunityModel _createCommunityModel({
  String id = _communityId,
}) {
  return CommunityModel(
    id: id,
    type: 'regular',
    name: 'Test Community',
    description: 'A test community',
    ownerId: _userId,
    memberIds: [_userId, 'user_2'],
    adminIds: [_userId],
    memberCount: 2,
    status: 'active',
    settings: const CommunitySettingsModel(),
    createdAt: DateTime(2024, 6, 1),
  );
}

/// Create a fake LocalCommunity row for local DB mock results.
LocalCommunity _createLocalCommunity({
  String id = _communityId,
  String name = 'Test Community',
}) {
  return LocalCommunity(
    id: id,
    type: 'regular',
    name: name,
    description: 'A test community',
    avatarUrl: null,
    ownerId: _userId,
    memberIdsJson: jsonEncode([_userId, 'user_2']),
    adminIdsJson: jsonEncode([_userId]),
    memberCount: 2,
    totalBalance: 0,
    status: 'active',
    settingsJson: jsonEncode({}),
    stokvelSettingsJson: null,
    lastMessageText: 'Hello',
    lastMessageSenderId: _userId,
    lastMessageSenderName: 'Alice',
    lastMessageType: 'text',
    lastMessageAt: DateTime(2024, 6, 1),
    unreadCountsJson: jsonEncode({_userId: 2, 'user_2': 0}),
    mutedJson: '{}',
    encryptedPreviewsJson: '{}',
    createdAt: DateTime(2024, 6, 1),
    updatedAt: null,
  );
}

LocalCommunityMember _createLocalMember({
  String userId = _userId,
}) {
  return LocalCommunityMember(
    id: '${_communityId}_$userId',
    communityId: _communityId,
    userId: userId,
    displayName: 'Alice',
    avatarUrl: null,
    role: 'owner',
    status: 'active',
    contributionBalance: 0,
    joinedAt: DateTime(2024, 6, 1),
    invitedBy: _userId,
    invitedAt: DateTime(2024, 6, 1),
    lastReadAt: null,
    createdAt: DateTime(2024, 6, 1),
  );
}

LocalFullMessage _createLocalMessage({
  String id = 'msg_1',
  String senderId = _userId,
  String text = 'Hello, community!',
}) {
  return LocalFullMessage(
    id: id,
    conversationId: _communityId,
    senderId: senderId,
    senderName: 'Alice',
    type: 'text',
    status: 'sent',
    textContent: text,
    mediaJson: null,
    giftJson: null,
    reactionsJson: null,
    replyToJson: null,
    forwardedFromJson: null,
    tokenAmount: null,
    recipientId: null,
    communityId: _communityId,
    deletedForJson: '{}',
    deletedForEveryone: false,
    expiresAt: null,
    readByJson: '{}',
    isDecrypted: true,
    createdAt: DateTime(2024, 6, 1, 12, 0),
  );
}

// ==================== TESTS ====================

void main() {
  late MockCommunityRemoteDataSource mockDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockAppDatabase mockAppDatabase;
  late MockOfflineActionQueue mockOfflineQueue;
  late MockOutgoingMessageQueue mockOutgoingQueue;
  late MockMediaUploadDatasource mockMediaUploadDatasource;
  late MockCommunitySyncService mockCommunitySyncService;
  late MockSenderKeyService mockSenderKeyService;
  late CommunityRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeCreateCommunityParams());
    registerFallbackValue(FakeUpdateCommunityParams());
    registerFallbackValue(FakeLocalCommunitiesCompanion());
    registerFallbackValue(MemberRole.member);
  });

  setUp(() {
    mockDataSource = MockCommunityRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockAppDatabase = MockAppDatabase();
    mockOfflineQueue = MockOfflineActionQueue();
    mockOutgoingQueue = MockOutgoingMessageQueue();
    mockMediaUploadDatasource = MockMediaUploadDatasource();
    mockCommunitySyncService = MockCommunitySyncService();
    mockSenderKeyService = MockSenderKeyService();

    repository = CommunityRepositoryImpl(
      mockDataSource,
      mockNetworkInfo,
      mockAppDatabase,
      mockOfflineQueue,
      mockOutgoingQueue,
      mockMediaUploadDatasource,
      mockCommunitySyncService,
      mockSenderKeyService,
    );

    when(() => mockDataSource.currentUserId).thenReturn(_userId);
  });

  // ===========================================================================
  // getUserCommunities — reads from local DB
  // ===========================================================================

  group('getUserCommunities', () {
    test('returns communities from local DB', () async {
      when(() => mockAppDatabase.getLocalCommunities())
          .thenAnswer((_) async => [_createLocalCommunity()]);

      final result = await repository.getUserCommunities();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (communities) {
          expect(communities.length, 1);
          expect(communities[0].id, _communityId);
          expect(communities[0].name, 'Test Community');
        },
      );
    });

    test('returns empty list when no local data', () async {
      when(() => mockAppDatabase.getLocalCommunities())
          .thenAnswer((_) async => []);

      final result = await repository.getUserCommunities();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (communities) => expect(communities, isEmpty),
      );
    });
  });

  // ===========================================================================
  // watchUserCommunities — streams from local DB
  // ===========================================================================

  group('watchUserCommunities', () {
    test('streams communities from local DB', () async {
      when(() => mockAppDatabase.watchLocalCommunities())
          .thenAnswer((_) => Stream.value([_createLocalCommunity()]));

      final emission = await repository.watchUserCommunities().first;

      expect(emission.isRight(), isTrue);
      emission.fold(
        (_) => fail('Expected Right'),
        (communities) {
          expect(communities.length, 1);
          expect(communities[0].id, _communityId);
        },
      );
    });
  });

  // ===========================================================================
  // getCommunity — local DB first, remote fallback
  // ===========================================================================

  group('getCommunity', () {
    test('returns from local DB when available', () async {
      when(() => mockAppDatabase.getLocalCommunity(_communityId))
          .thenAnswer((_) async => _createLocalCommunity());

      final result = await repository.getCommunity(_communityId);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (community) {
          expect(community.id, _communityId);
          expect(community.name, 'Test Community');
        },
      );
      verifyNever(() => mockDataSource.getCommunity(any()));
    });

    test('falls back to remote when not in local DB', () async {
      when(() => mockAppDatabase.getLocalCommunity('not_local'))
          .thenAnswer((_) async => null);
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.getCommunity('not_local'))
          .thenAnswer((_) async => _createCommunityModel(id: 'not_local'));

      final result = await repository.getCommunity('not_local');

      expect(result.isRight(), isTrue);
    });

    test('returns Left(network) when not in local DB and offline', () async {
      when(() => mockAppDatabase.getLocalCommunity('offline_test'))
          .thenAnswer((_) async => null);
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);

      final result = await repository.getCommunity('offline_test');

      expect(result, const Left(Failure.network()));
    });

    test('returns Left(serverError) when community not found remotely',
        () async {
      when(() => mockAppDatabase.getLocalCommunity('not_found'))
          .thenAnswer((_) async => null);
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.getCommunity('not_found'))
          .thenAnswer((_) async => null);

      final result = await repository.getCommunity('not_found');

      expect(result.isLeft(), isTrue);
    });
  });

  // ===========================================================================
  // getMessages — reads pre-decrypted from local DB
  // ===========================================================================

  group('getMessages', () {
    test('returns pre-decrypted messages from local DB', () async {
      when(() => mockAppDatabase.getLocalMessages(
            _communityId,
            limit: 50,
            before: null,
          )).thenAnswer((_) async => [_createLocalMessage()]);

      final result = await repository.getMessages(communityId: _communityId);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Hello, community!');
        },
      );
    });

    test('applies before filter', () async {
      final before = DateTime(2024, 1, 1);
      when(() => mockAppDatabase.getLocalMessages(
            _communityId,
            limit: 50,
            before: before,
          )).thenAnswer((_) async => []);

      final result = await repository.getMessages(
        communityId: _communityId,
        before: before,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) => expect(messages, isEmpty),
      );
    });

    test('applies limit', () async {
      when(() => mockAppDatabase.getLocalMessages(
            _communityId,
            limit: 2,
            before: null,
          )).thenAnswer((_) async => [
                _createLocalMessage(id: 'msg_1'),
                _createLocalMessage(id: 'msg_2'),
              ]);

      final result = await repository.getMessages(
        communityId: _communityId,
        limit: 2,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) => expect(messages.length, 2),
      );
    });
  });

  // ===========================================================================
  // watchMessages — streams pre-decrypted from local DB
  // ===========================================================================

  group('watchMessages', () {
    test('streams pre-decrypted messages from local DB', () async {
      when(() => mockAppDatabase.watchLocalMessages(_communityId))
          .thenAnswer((_) => Stream.value([_createLocalMessage()]));

      final emission = await repository
          .watchMessages(communityId: _communityId)
          .first;

      expect(emission.isRight(), isTrue);
      emission.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Hello, community!');
        },
      );
    });
  });

  // ===========================================================================
  // sendTextMessage — delegates to OutgoingMessageQueue
  // ===========================================================================

  group('sendTextMessage', () {
    test('enqueues via OutgoingMessageQueue', () async {
      final optimistic = Message(
        id: 'pending_123',
        senderId: _userId,
        senderName: '',
        type: MessageType.text,
        status: MessageStatus.sending,
        textContent: 'Hello',
        communityId: _communityId,
        createdAt: DateTime.now(),
      );
      when(() => mockOutgoingQueue.enqueueCommunityTextMessage(
            communityId: _communityId,
            text: 'Hello',
            replyToMessageId: null,
          )).thenAnswer((_) async => optimistic);

      final result = await repository.sendTextMessage(
        communityId: _communityId,
        text: 'Hello',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (message) {
          expect(message.textContent, 'Hello');
          expect(message.communityId, _communityId);
        },
      );
      verify(() => mockOutgoingQueue.enqueueCommunityTextMessage(
            communityId: _communityId,
            text: 'Hello',
            replyToMessageId: null,
          )).called(1);
    });

    test('returns Left when queue throws', () async {
      when(() => mockOutgoingQueue.enqueueCommunityTextMessage(
            communityId: any(named: 'communityId'),
            text: any(named: 'text'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenThrow(Exception('Queue error'));

      final result = await repository.sendTextMessage(
        communityId: _communityId,
        text: 'Hello',
      );

      expect(result.isLeft(), isTrue);
    });
  });

  // ===========================================================================
  // getMembers — reads from local DB
  // ===========================================================================

  group('getMembers', () {
    test('returns members from local DB', () async {
      when(() => mockAppDatabase.getLocalCommunityMembers(_communityId))
          .thenAnswer((_) async => [_createLocalMember()]);

      final result = await repository.getMembers(_communityId);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (members) {
          expect(members.length, 1);
          expect(members[0].userId, _userId);
          expect(members[0].displayName, 'Alice');
        },
      );
    });
  });

  // ===========================================================================
  // addReaction / removeReaction — routed through OfflineActionQueue
  // ===========================================================================

  group('addReaction', () {
    test('enqueues via OfflineActionQueue', () async {
      when(() => mockOfflineQueue.enqueue(
            table: any(named: 'table'),
            recordId: any(named: 'recordId'),
            changeType: any(named: 'changeType'),
            data: any(named: 'data'),
          )).thenAnswer((_) async {});

      final result = await repository.addReaction(
        communityId: _communityId,
        messageId: 'msg_1',
        emoji: '🎉',
      );

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'community_messages',
            recordId: 'msg_1',
            changeType: 'community_add_reaction',
            data: {'communityId': _communityId, 'emoji': '🎉'},
          )).called(1);
    });
  });

  group('removeReaction', () {
    test('enqueues via OfflineActionQueue', () async {
      when(() => mockOfflineQueue.enqueue(
            table: any(named: 'table'),
            recordId: any(named: 'recordId'),
            changeType: any(named: 'changeType'),
            data: any(named: 'data'),
          )).thenAnswer((_) async {});

      final result = await repository.removeReaction(
        communityId: _communityId,
        messageId: 'msg_1',
        emoji: '🎉',
      );

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'community_messages',
            recordId: 'msg_1',
            changeType: 'community_remove_reaction',
            data: {'communityId': _communityId, 'emoji': '🎉'},
          )).called(1);
    });
  });

  // ===========================================================================
  // watchTotalCommunityUnreadCount — computed from local DB
  // ===========================================================================

  group('watchTotalCommunityUnreadCount', () {
    test('sums unread counts from local communities', () async {
      when(() => mockAppDatabase.watchLocalCommunities()).thenAnswer(
        (_) => Stream.value([
          _createLocalCommunity(id: 'c1'),
          _createLocalCommunity(id: 'c2'),
        ]),
      );

      final emission =
          await repository.watchTotalCommunityUnreadCount().first;

      expect(emission.isRight(), isTrue);
      emission.fold(
        (_) => fail('Expected Right'),
        // Each community has unreadCounts: {user_1: 2, user_2: 0}
        // So total for user_1 = 2 + 2 = 4
        (count) => expect(count, 4),
      );
    });
  });

  // ===========================================================================
  // Passthrough methods (still hit remote)
  // ===========================================================================

  group('createCommunity', () {
    test('delegates to datasource when connected', () async {
      final params = CreateCommunityParams(
        type: CommunityType.regular,
        name: 'New Community',
      );
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.createCommunity(any()))
          .thenAnswer((_) async => _createCommunityModel());
      when(() => mockAppDatabase.upsertLocalCommunity(any()))
          .thenAnswer((_) async {});

      final result = await repository.createCommunity(params);

      expect(result.isRight(), isTrue);
    });

    test('returns Left(network) when datasource throws SocketException',
        () async {
      when(() => mockDataSource.createCommunity(any())).thenThrow(
          const SocketException('No Internet connection'));

      final result = await repository.createCommunity(
        CreateCommunityParams(
          type: CommunityType.regular,
          name: 'Test',
        ),
      );

      expect(result, const Left(Failure.network()));
    });
  });

  group('leaveCommunity', () {
    test('delegates to datasource correctly when connected', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.leaveCommunity(_communityId))
          .thenAnswer((_) async {});

      final result = await repository.leaveCommunity(_communityId);

      expect(result, const Right(null));
      verify(() => mockDataSource.leaveCommunity(_communityId)).called(1);
    });

    test('returns Left(network) when not connected', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);

      final result = await repository.leaveCommunity(_communityId);

      expect(result, const Left(Failure.network()));
    });
  });

  group('inviteMember', () {
    test('delegates to datasource with correct params', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.inviteMember(
              _communityId, 'user_2', MemberRole.member))
          .thenAnswer((_) async {});

      final result = await repository.inviteMember(
        _communityId,
        'user_2',
        MemberRole.member,
      );

      expect(result, const Right(null));
    });
  });

  group('deleteCommunity', () {
    test('delegates to datasource correctly when connected', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.deleteCommunity(_communityId))
          .thenAnswer((_) async {});
      when(() => mockCommunitySyncService.stopSyncingCommunity(_communityId))
          .thenReturn(null);
      when(() => mockAppDatabase.deleteLocalCommunity(_communityId))
          .thenAnswer((_) async {});
      when(() =>
              mockAppDatabase.deleteLocalCommunityMembersForCommunity(_communityId))
          .thenAnswer((_) async {});
      when(() =>
              mockAppDatabase.deleteLocalMessagesForConversation(_communityId))
          .thenAnswer((_) async {});
      when(() => mockSenderKeyService.resetAllKeysForCommunity(_communityId))
          .thenAnswer((_) async {});

      final result = await repository.deleteCommunity(_communityId);

      expect(result, const Right(null));
      verify(() => mockDataSource.deleteCommunity(_communityId)).called(1);
    });
  });
}
