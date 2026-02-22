import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/data/models/conversation_model.dart';
import 'package:imalichat/data/models/message_model.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/media_upload_datasource.dart';
import 'package:imalichat/data/repositories/conversation_repository_impl.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/offline_action_queue.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

// ==================== MOCKS ====================

class MockConversationRemoteDataSource extends Mock
    implements ConversationRemoteDataSource {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockMediaUploadDatasource extends Mock implements MediaUploadDatasource {}

class MockMessageSyncService extends Mock implements MessageSyncService {}

class MockOfflineActionQueue extends Mock implements OfflineActionQueue {}

// ==================== TEST FIXTURES ====================

const _userId = 'user_1';
const _recipientId = 'user_2';
const _conversationId = 'conv_123';

ConversationModel _createConversationModel({
  String id = _conversationId,
  List<String>? participantIds,
}) {
  return ConversationModel(
    id: id,
    type: 'p2p',
    participantIds: participantIds ?? [_userId, _recipientId],
    participants: {
      _userId: {'displayName': 'Alice'},
      _recipientId: {'displayName': 'Bob'},
    },
    unreadCounts: {_userId: 0, _recipientId: 1},
    archived: {},
    pinned: {},
    muted: {},
    createdAt: DateTime(2024, 6, 1),
  );
}

MessageModel _createPlaintextModel({
  String id = 'msg_1',
  String senderId = _userId,
}) {
  return MessageModel(
    id: id,
    senderId: senderId,
    senderName: 'Alice',
    type: 'text',
    status: 'sent',
    textContent: 'Hello, world!',
    createdAt: DateTime(2024, 6, 1, 12, 0),
  );
}

/// Creates a LocalFullMessage row matching a decrypted message in local DB
LocalFullMessage _createLocalFullMessage({
  String id = 'msg_1',
  String senderId = _userId,
  String senderName = 'Alice',
  String type = 'text',
  String status = 'sent',
  String? textContent = 'Hello, world!',
  bool isDecrypted = true,
  String conversationId = _conversationId,
}) {
  return LocalFullMessage(
    id: id,
    conversationId: conversationId,
    senderId: senderId,
    senderName: senderName,
    type: type,
    status: status,
    textContent: textContent,
    isDecrypted: isDecrypted,
    createdAt: DateTime(2024, 6, 1, 12, 0),
    deletedForJson: '[]',
    deletedForEveryone: false,
    senderAvatarUrl: null,
    tokenAmount: null,
    recipientId: null,
    ledgerJournalId: null,
    mediaJson: null,
    reactionsJson: null,
    replyToJson: null,
    giftJson: null,
    tokenSprayJson: null,
    communityId: null,
    systemEventType: null,
    systemEventDataJson: null,
    expiresAt: null,
    actionedAt: null,
    deletedAt: null,
  );
}

// ==================== TESTS ====================

void main() {
  late MockConversationRemoteDataSource mockDataSource;
  late MockSignalProtocolService mockSignalProtocol;
  late MockAppDatabase mockAppDatabase;
  late MockMessageSyncService mockSyncService;
  late MockOfflineActionQueue mockOfflineQueue;
  late ConversationRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(LocalFullMessagesCompanion.insert(
      id: '',
      conversationId: '',
      senderId: '',
      senderName: '',
      type: '',
      status: '',
      createdAt: DateTime(2024),
    ));
  });

  setUp(() {
    mockDataSource = MockConversationRemoteDataSource();
    mockSignalProtocol = MockSignalProtocolService();
    mockAppDatabase = MockAppDatabase();
    mockSyncService = MockMessageSyncService();
    mockOfflineQueue = MockOfflineActionQueue();
    // Stub fire-and-forget DB cache calls used by the repository
    when(() => mockAppDatabase.cacheDecryptedPlaintext(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.getDecryptedPlaintext(any()))
        .thenAnswer((_) async => null);
    // Stub local DB operations for optimistic insert/delete
    when(() => mockAppDatabase.upsertLocalMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.deleteLocalMessage(any()))
        .thenAnswer((_) async {});
    // Stub peer identity key lookup used by _ensureSessionFresh
    when(() => mockDataSource.getUserE2eeIdentityKey(any()))
        .thenAnswer((_) async => null);
    // Stub currentUserId — most send methods check this
    when(() => mockDataSource.currentUserId).thenReturn(_userId);
    // Stub sync service sent plaintext cache
    when(() => mockSyncService.sentPlaintextCache).thenReturn({});
    // Stub offline queue enqueue (returns Future<void>)
    when(() => mockOfflineQueue.enqueue(
          table: any(named: 'table'),
          recordId: any(named: 'recordId'),
          changeType: any(named: 'changeType'),
          data: any(named: 'data'),
        )).thenAnswer((_) async {});
    repository = ConversationRepositoryImpl(
      mockDataSource,
      mockSignalProtocol,
      mockAppDatabase,
      MockMediaUploadDatasource(),
      mockSyncService,
      mockOfflineQueue,
    );
  });

  // ===========================================================================
  // sendTextMessage
  // ===========================================================================

  group('sendTextMessage', () {
    test('calls encryptP2P with the recipient ID and plaintext', () async {
      final convModel = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hi'))
          .thenAnswer((_) async => {
                'ciphertext': 'encrypted_ct',
                'e2ee': {'protocol': 'signal-v1', 'messageNumber': 0},
                'x3dhHeader': null,
              });
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: _conversationId,
            ciphertext: 'encrypted_ct',
            e2ee: {'protocol': 'signal-v1', 'messageNumber': 0},
            x3dhHeader: null,
            replyToMessageId: null,
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hi',
      );

      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hi'))
          .called(1);
    });

    test('sends encrypted message to datasource on encryption success',
        () async {
      final convModel = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => {
                'ciphertext': 'ct_base64',
                'e2ee': {'protocol': 'signal-v1', 'messageNumber': 1},
                'x3dhHeader': {
                  'identityKey': 'ik',
                  'ephemeralKey': 'ek',
                  'oneTimePreKeyId': 0,
                },
              });
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: _conversationId,
            ciphertext: 'ct_base64',
            e2ee: {'protocol': 'signal-v1', 'messageNumber': 1},
            x3dhHeader: {
              'identityKey': 'ik',
              'ephemeralKey': 'ek',
              'oneTimePreKeyId': 0,
            },
            replyToMessageId: null,
          )).thenAnswer((_) async => 'msg_002');

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (message) {
          expect(message.textContent, 'Hello');
          expect(message.id, 'msg_002');
          expect(message.type, MessageType.text);
          expect(message.status, MessageStatus.sent);
        },
      );
      verify(() => mockDataSource.sendEncryptedMessage(
            conversationId: _conversationId,
            ciphertext: 'ct_base64',
            e2ee: {'protocol': 'signal-v1', 'messageNumber': 1},
            x3dhHeader: {
              'identityKey': 'ik',
              'ephemeralKey': 'ek',
              'oneTimePreKeyId': 0,
            },
            replyToMessageId: null,
          )).called(1);
    });

    test('returns Left(serverError) when encryptP2P throws (no plaintext fallback)',
        () async {
      final convModel = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Fallback'))
          .thenThrow(StateError('No session'));

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Fallback',
      );

      expect(result.isLeft(), isTrue);
      // No plaintext fallback — encryption failure is a hard error
      verifyNever(() => mockDataSource.sendTextMessage(
            conversationId: any(named: 'conversationId'),
            text: any(named: 'text'),
            replyToMessageId: any(named: 'replyToMessageId'),
          ));
    });

    test('returns Left(serverError) when recipient cannot be determined',
        () async {
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => null);

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result.isLeft(), isTrue);
      verifyNever(
          () => mockSignalProtocol.encryptP2P(any(), any()));
    });

    test('passes correct conversationId to encrypted datasource', () async {
      const customConvId = 'conv_custom_999';
      final convModel = _createConversationModel(id: customConvId);
      when(() => mockDataSource.getConversationById(customConvId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Msg'))
          .thenAnswer((_) async => {
                'ciphertext': 'ct_msg',
                'e2ee': {'protocol': 'signal-v1', 'messageNumber': 0},
                'x3dhHeader': null,
              });
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: customConvId,
            ciphertext: 'ct_msg',
            e2ee: {'protocol': 'signal-v1', 'messageNumber': 0},
            x3dhHeader: null,
            replyToMessageId: null,
          )).thenAnswer((_) async => 'msg_custom');

      await repository.sendTextMessage(
        conversationId: customConvId,
        text: 'Msg',
      );

      verify(() => mockDataSource.sendEncryptedMessage(
            conversationId: customConvId,
            ciphertext: 'ct_msg',
            e2ee: {'protocol': 'signal-v1', 'messageNumber': 0},
            x3dhHeader: null,
            replyToMessageId: null,
          )).called(1);
    });

    test('passes replyToMessageId through to encrypted datasource', () async {
      final convModel = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Reply text'))
          .thenAnswer((_) async => {
                'ciphertext': 'ct_reply',
                'e2ee': {'protocol': 'signal-v1', 'messageNumber': 0},
                'x3dhHeader': null,
              });
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: _conversationId,
            ciphertext: 'ct_reply',
            e2ee: {'protocol': 'signal-v1', 'messageNumber': 0},
            x3dhHeader: null,
            replyToMessageId: 'parent_msg_1',
          )).thenAnswer((_) async => 'msg_reply');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Reply text',
        replyToMessageId: 'parent_msg_1',
      );

      verify(() => mockDataSource.sendEncryptedMessage(
            conversationId: _conversationId,
            ciphertext: 'ct_reply',
            e2ee: {'protocol': 'signal-v1', 'messageNumber': 0},
            x3dhHeader: null,
            replyToMessageId: 'parent_msg_1',
          )).called(1);
    });

    test('returns Left(unauthenticated) when currentUserId is null',
        () async {
      when(() => mockDataSource.currentUserId).thenReturn(null);

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(unauthenticated) when AuthException is thrown',
        () async {
      final convModel = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Test'))
          .thenAnswer((_) async => {
                'ciphertext': 'ct_test',
                'e2ee': {'protocol': 'signal-v1', 'messageNumber': 0},
                'x3dhHeader': null,
              });
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenThrow(const AuthException(message: 'Not logged in'));

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) when ServerException is thrown', () async {
      final convModel = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Test'))
          .thenAnswer((_) async => {
                'ciphertext': 'ct_test',
                'e2ee': {'protocol': 'signal-v1', 'messageNumber': 0},
                'x3dhHeader': null,
              });
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenThrow(const ServerException(message: 'Server down'));

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure,
            const Failure.serverError(message: 'Server down')),
        (_) => fail('Expected Left'),
      );
    });
  });

  // ===========================================================================
  // getMessages — now reads from local DB (pre-decrypted by MessageSyncService)
  // ===========================================================================

  group('getMessages', () {
    test('reads messages from local DB and returns entities', () async {
      when(() => mockAppDatabase.getLocalMessages(
            _conversationId,
            limit: 50,
            before: null,
          )).thenAnswer((_) async => [
            _createLocalFullMessage(id: 'msg_1', textContent: 'Hello'),
            _createLocalFullMessage(id: 'msg_2', textContent: 'World'),
          ]);

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 2);
          expect(messages[0].textContent, 'Hello');
          expect(messages[1].textContent, 'World');
        },
      );
    });

    test('returns empty list when no local messages', () async {
      when(() => mockAppDatabase.getLocalMessages(
            _conversationId,
            limit: 50,
            before: null,
          )).thenAnswer((_) async => []);

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) => expect(messages.isEmpty, isTrue),
      );
    });

    test('does not call decryptP2P (decryption handled by sync service)',
        () async {
      when(() => mockAppDatabase.getLocalMessages(
            _conversationId,
            limit: 50,
            before: null,
          )).thenAnswer((_) async => [
            _createLocalFullMessage(textContent: 'Already decrypted'),
          ]);

      await repository.getMessages(conversationId: _conversationId);

      verifyNever(() => mockSignalProtocol.decryptP2P(any(), any()));
    });

    test('returns Left on database error', () async {
      when(() => mockAppDatabase.getLocalMessages(
            _conversationId,
            limit: 50,
            before: null,
          )).thenThrow(Exception('DB error'));

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isLeft(), isTrue);
    });
  });

  // ===========================================================================
  // watchMessages — now streams from local DB (pre-decrypted)
  // ===========================================================================

  group('watchMessages', () {
    test('streams messages from local DB', () async {
      when(() => mockAppDatabase.watchLocalMessages(
            _conversationId,
            limit: 50,
          )).thenAnswer((_) => Stream.value([
            _createLocalFullMessage(id: 'msg_1', textContent: 'Streamed'),
          ]));

      final stream = repository.watchMessages(
        conversationId: _conversationId,
      );

      final emission = await stream.first;
      expect(emission.isRight(), isTrue);
      emission.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Streamed');
        },
      );
    });

    test('does not call decryptP2P (decryption handled by sync service)',
        () async {
      when(() => mockAppDatabase.watchLocalMessages(
            _conversationId,
            limit: 50,
          )).thenAnswer((_) => Stream.value([
            _createLocalFullMessage(textContent: 'Pre-decrypted'),
          ]));

      final stream = repository.watchMessages(
        conversationId: _conversationId,
      );
      await stream.first;

      verifyNever(() => mockSignalProtocol.decryptP2P(any(), any()));
    });
  });

  // ===========================================================================
  // Metadata operations — now routed through OfflineActionQueue
  // ===========================================================================

  group('markAsRead', () {
    test('enqueues action via offline queue', () async {
      final result = await repository.markAsRead(
        conversationId: _conversationId,
      );

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'conversations',
            recordId: _conversationId,
            changeType: 'mark_read',
            data: {},
          )).called(1);
    });
  });

  group('getConversationById', () {
    test('delegates to datasource and returns entity', () async {
      final model = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => model);

      final result = await repository.getConversationById(_conversationId);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (conv) {
          expect(conv.id, _conversationId);
          expect(conv.participantIds, [_userId, _recipientId]);
        },
      );
    });

    test('returns Left(serverError) when conversation not found', () async {
      when(() => mockDataSource.getConversationById('not_found'))
          .thenAnswer((_) async => null);

      final result = await repository.getConversationById('not_found');

      expect(result.isLeft(), isTrue);
    });
  });

  group('sendTokens', () {
    test('delegates to datasource with correct params', () async {
      final model = _createPlaintextModel();
      // Stub encryption for the optional message text
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Enjoy!'))
          .thenAnswer((_) async => {
                'ciphertext': 'ct_enjoy',
                'e2ee': {'protocol': 'signal-v1', 'messageNumber': 0},
                'x3dhHeader': null,
              });
      when(() => mockDataSource.sendTokens(
            conversationId: any(named: 'conversationId'),
            recipientId: any(named: 'recipientId'),
            amount: any(named: 'amount'),
            encryptedMessage: any(named: 'encryptedMessage'),
            messageE2ee: any(named: 'messageE2ee'),
            messageX3dh: any(named: 'messageX3dh'),
          )).thenAnswer((_) async => model);

      final result = await repository.sendTokens(
        conversationId: _conversationId,
        recipientId: _recipientId,
        amount: 100,
        message: 'Enjoy!',
      );

      expect(result.isRight(), isTrue);
    });

    test('returns Left(insufficientBalance) on InsufficientBalanceException',
        () async {
      when(() => mockDataSource.sendTokens(
            conversationId: any(named: 'conversationId'),
            recipientId: any(named: 'recipientId'),
            amount: any(named: 'amount'),
            encryptedMessage: any(named: 'encryptedMessage'),
            messageE2ee: any(named: 'messageE2ee'),
            messageX3dh: any(named: 'messageX3dh'),
          )).thenThrow(InsufficientBalanceException());

      final result = await repository.sendTokens(
        conversationId: _conversationId,
        recipientId: _recipientId,
        amount: 99999,
      );

      expect(result, const Left(Failure.insufficientBalance()));
    });
  });

  group('togglePin', () {
    test('enqueues action via offline queue', () async {
      final result = await repository.togglePin(
        conversationId: _conversationId,
        pinned: true,
      );

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'conversations',
            recordId: _conversationId,
            changeType: 'toggle_pin',
            data: {'pinned': true},
          )).called(1);
    });
  });

  group('toggleMute', () {
    test('enqueues action via offline queue', () async {
      final result = await repository.toggleMute(
        conversationId: _conversationId,
        muted: true,
      );

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'conversations',
            recordId: _conversationId,
            changeType: 'toggle_mute',
            data: {'muted': true},
          )).called(1);
    });
  });

  group('archiveConversation', () {
    test('enqueues action via offline queue', () async {
      final result =
          await repository.archiveConversation(_conversationId);

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'conversations',
            recordId: _conversationId,
            changeType: 'archive',
            data: {},
          )).called(1);
    });
  });

  group('addReaction', () {
    test('enqueues action via offline queue', () async {
      final result = await repository.addReaction(
        conversationId: _conversationId,
        messageId: 'msg_1',
        emoji: '👍',
      );

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'messages',
            recordId: 'msg_1',
            changeType: 'add_reaction',
            data: {'conversationId': _conversationId, 'emoji': '👍'},
          )).called(1);
    });
  });

  group('removeReaction', () {
    test('enqueues action via offline queue', () async {
      final result = await repository.removeReaction(
        conversationId: _conversationId,
        messageId: 'msg_1',
        emoji: '👍',
      );

      expect(result, const Right(null));
      verify(() => mockOfflineQueue.enqueue(
            table: 'messages',
            recordId: 'msg_1',
            changeType: 'remove_reaction',
            data: {'conversationId': _conversationId, 'emoji': '👍'},
          )).called(1);
    });
  });

  group('getTotalUnreadCount', () {
    test('delegates to datasource and returns count', () async {
      when(() => mockDataSource.getTotalUnreadCount())
          .thenAnswer((_) async => 5);

      final result = await repository.getTotalUnreadCount();

      expect(result, const Right(5));
    });
  });
}
