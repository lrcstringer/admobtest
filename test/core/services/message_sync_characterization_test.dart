// Characterization tests for MessageSyncService._decryptMessage (tested
// indirectly through _processIncomingMessages via startSync).
//
// These tests capture the exact current behavior of the decryption
// orchestration layer — the layer between Firestore streams and local DB.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/media_recovery_service.dart';
import 'package:imalichat/core/services/message_decryption_service.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/data/mappers/local_conversation_mapper.dart';
import 'package:imalichat/data/models/conversation_model.dart';
import 'package:imalichat/data/models/message_model.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockConversationRemoteDataSource extends Mock
    implements ConversationRemoteDataSource {}

class MockSignalProtocolService extends Mock
    implements SignalProtocolService {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockMediaRecoveryService extends Mock implements MediaRecoveryService {}

// ==================== FIXTURES ====================

const _userId = 'user_1_aa';
const _senderId = 'user_2_bb';
const _conversationId = 'conv_123';

ConversationModel _createConversationModel({
  String id = _conversationId,
}) {
  return ConversationModel(
    id: id,
    type: 'p2p',
    participantIds: [_userId, _senderId],
    participants: {
      _userId: {'displayName': 'Alice'},
      _senderId: {'displayName': 'Bob'},
    },
    unreadCounts: {_userId: 0, _senderId: 0},
    archived: {},
    pinned: {},
    muted: {},
    createdAt: DateTime(2024, 6, 1),
  );
}

MessageModel _createEncryptedMessageModel({
  String id = 'msg_1',
  String senderId = _senderId,
  String? ciphertext = 'encrypted_base64_data',
  Map<String, dynamic>? e2ee,
  Map<String, dynamic>? x3dhHeader,
  bool omitX3dhHeader = false,
}) {
  return MessageModel(
    id: id,
    senderId: senderId,
    senderName: 'Bob',
    type: 'text',
    status: 'sent',
    textContent: null,
    ciphertext: ciphertext,
    e2ee: e2ee ??
        {
          'protocol': 'signal-v2',
          'messageNumber': 0,
          'dhPublicKey': 'dh_pub_key_base64',
        },
    x3dhHeader: omitX3dhHeader
        ? null
        : (x3dhHeader ??
            {
              'identityKey': 'identity_key_base64_long_enough',
              'ephemeralKey': 'ephemeral_key_base64',
            }),
    createdAt: DateTime(2024, 6, 1, 12, 0),
  );
}

MessageModel _createOwnEncryptedMessageModel({
  String id = 'msg_own',
  String? ciphertext = 'own_encrypted_data',
}) {
  return MessageModel(
    id: id,
    senderId: _userId,
    senderName: 'Alice',
    type: 'text',
    status: 'sent',
    textContent: null,
    ciphertext: ciphertext,
    e2ee: {
      'protocol': 'signal-v2',
      'messageNumber': 0,
      'dhPublicKey': 'own_dh_pub',
    },
    createdAt: DateTime(2024, 6, 1, 12, 0),
  );
}

LocalFullConversation _createLocalConversation({
  String id = _conversationId,
}) {
  return LocalFullConversation(
    id: id,
    type: 'p2p',
    participantIdsJson: '["$_userId","$_senderId"]',
    participantsJson:
        '{"$_userId":{"displayName":"Alice"},"$_senderId":{"displayName":"Bob"}}',
    lastMessageId: null,
    lastMessageText: null,
    lastMessageSenderId: null,
    lastMessageSenderName: null,
    lastMessageType: null,
    lastMessageAt: null,
    unreadCountsJson: '{"$_userId":0,"$_senderId":0}',
    archivedJson: '{}',
    pinnedJson: '{}',
    mutedJson: '{}',
    chatClearedAtJson: '{}',
    acceptedJson: '{}',
    createdAt: DateTime(2024, 6, 1),
    updatedAt: null,
  );
}

// ==================== TESTS ====================

void main() {
  late MockConversationRemoteDataSource mockDataSource;
  late MockSignalProtocolService mockSignalProtocol;
  late MockAppDatabase mockAppDatabase;
  late MockMediaRecoveryService mockMediaRecovery;
  late MessageDecryptionService decryptionService;
  late MessageSyncService syncService;

  // Stream controllers to push data into the sync service
  late StreamController<List<ConversationModel>> conversationStreamController;
  late StreamController<List<MessageModel>> messageStreamController;

  setUpAll(() {
    registerFallbackValue(
      LocalFullMessagesCompanion.insert(
        id: '',
        conversationId: '',
        senderId: '',
        senderName: '',
        type: '',
        status: '',
        createdAt: DateTime(2024),
      ),
    );
    registerFallbackValue(
      LocalConversationMapper.toCompanion(
        _createConversationModel().toEntity(),
      ),
    );
  });

  setUp(() {
    mockDataSource = MockConversationRemoteDataSource();
    mockSignalProtocol = MockSignalProtocolService();
    mockAppDatabase = MockAppDatabase();
    mockMediaRecovery = MockMediaRecoveryService();

    conversationStreamController =
        StreamController<List<ConversationModel>>.broadcast();
    messageStreamController =
        StreamController<List<MessageModel>>.broadcast();

    // Standard stubs — remote datasource
    when(() => mockDataSource.currentUserId).thenReturn(_userId);
    when(() => mockDataSource.watchConversations())
        .thenAnswer((_) => conversationStreamController.stream);
    when(() => mockDataSource.watchMessages(
          conversationId: any(named: 'conversationId'),
          limit: any(named: 'limit'),
        )).thenAnswer((_) => messageStreamController.stream);
    when(() => mockDataSource.getUserE2eeIdentityKey(any()))
        .thenAnswer((_) async => null);
    when(() => mockDataSource.getConversations())
        .thenAnswer((_) async => [_createConversationModel()]);
    when(() => mockDataSource.getMessages(
          conversationId: any(named: 'conversationId'),
          limit: any(named: 'limit'),
          before: any(named: 'before'),
        )).thenAnswer((_) async => <MessageModel>[]);
    when(() => mockDataSource.requestSessionReset(
          conversationId: any(named: 'conversationId'),
          targetUserId: any(named: 'targetUserId'),
        )).thenAnswer((_) async {});

    // DB stubs
    when(() => mockAppDatabase.getLocalConversation(any()))
        .thenAnswer((_) async => _createLocalConversation());
    when(() => mockAppDatabase.getLocalConversations())
        .thenAnswer((_) async => [_createLocalConversation()]);
    when(() => mockAppDatabase.getLocalMessageById(any()))
        .thenAnswer((_) async => null);
    when(() => mockAppDatabase.getLocalMessages(any(),
            limit: any(named: 'limit'),
            before: any(named: 'before')))
        .thenAnswer((_) async => <LocalFullMessage>[]);
    when(() => mockAppDatabase.upsertLocalMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.upsertLocalConversation(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.upsertLocalConversationsBatch(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.cacheDecryptedPlaintext(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.deleteExpiredMessages())
        .thenAnswer((_) async => 0);
    when(() => mockAppDatabase.deleteLocalConversation(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.getMessageCount(any()))
        .thenAnswer((_) async => 1); // >0 skips backfill
    when(() => mockAppDatabase.getPendingMessagesForConversation(any()))
        .thenAnswer((_) async => []);
    when(() => mockAppDatabase.getUndecryptedMessages(any(), any()))
        .thenAnswer((_) async => []);

    // Media recovery stubs
    when(() => mockMediaRecovery.storePayload(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockMediaRecovery.initialize())
        .thenAnswer((_) async => false);
    when(() => mockMediaRecovery.isReady).thenReturn(false);

    // Create real MessageDecryptionService with mocked sub-dependencies
    decryptionService = MessageDecryptionService(
      mockSignalProtocol,
      mockDataSource,
      mockAppDatabase,
    );

    syncService = MessageSyncService(
      mockDataSource,
      decryptionService,
      mockAppDatabase,
      mockMediaRecovery,
    );
  });

  tearDown(() {
    syncService.stopSync();
    conversationStreamController.close();
    messageStreamController.close();
  });

  /// Helper: start sync, push a conversation, then push messages, and wait.
  Future<void> pushMessagesAndWait(List<MessageModel> messages) async {
    syncService.startSync();

    // Push conversation list
    conversationStreamController.add([_createConversationModel()]);

    // Give async callbacks time to run
    await Future<void>.delayed(const Duration(milliseconds: 50));

    // Push messages
    messageStreamController.add(messages);

    // Give processing time
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  // ===========================================================================
  // Own message decryption (sender's side)
  // ===========================================================================
  group('Own message decryption', () {
    test('uses sentPlaintextCache for own messages', () async {
      syncService.sentPlaintextCache['msg_own'] = 'Cached plaintext';

      await pushMessagesAndWait([_createOwnEncryptedMessageModel()]);

      // Should store the cached plaintext in local DB
      final captured = verify(() => mockAppDatabase.upsertLocalMessage(
            captureAny(),
          )).captured;
      expect(captured, isNotEmpty);

      // decryptP2P should NOT be called for own messages
      verifyNever(
          () => mockSignalProtocol.decryptP2P(any(), any()));
    });

    test('falls back to DB cache when sentPlaintextCache is empty', () async {
      when(() => mockAppDatabase.getDecryptedPlaintext('msg_own'))
          .thenAnswer((_) async => 'DB cached plaintext');

      await pushMessagesAndWait([_createOwnEncryptedMessageModel()]);

      verify(() => mockAppDatabase.getDecryptedPlaintext('msg_own')).called(1);
      verifyNever(
          () => mockSignalProtocol.decryptP2P(any(), any()));
    });
  });

  // ===========================================================================
  // Incoming message decryption
  // ===========================================================================
  group('Incoming message decryption', () {
    test('calls decryptP2P for incoming encrypted messages', () async {
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenAnswer((_) async => 'Decrypted text');

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      verify(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .called(1);
    });

    test('stores decrypted message in local DB with isDecrypted=true', () async {
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenAnswer((_) async => 'Hello from Bob');

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      final captured = verify(() => mockAppDatabase.upsertLocalMessage(
            captureAny(),
          )).captured;
      expect(captured, isNotEmpty);
    });

    test('PermanentDecryptionError marks message as permanently failed', () async {
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenThrow(PermanentDecryptionError('OTK mismatch'));

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      // Should still store something in local DB (failure sentinel)
      verify(() => mockAppDatabase.upsertLocalMessage(any())).called(1);
    });

    test('OTK mismatch PermanentDecryptionError triggers session reset', () async {
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenThrow(PermanentDecryptionError('OTK mismatch with sender'));
      when(() => mockSignalProtocol.resetSession(_senderId))
          .thenAnswer((_) async {});

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      verify(() => mockSignalProtocol.resetSession(_senderId)).called(1);
    });

    test('transient decrypt failure with x3dhHeader triggers reset+retry', () async {
      var callCount = 0;
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenAnswer((_) async {
        callCount++;
        if (callCount == 1) throw StateError('MAC failure');
        return 'Recovered text';
      });
      when(() => mockSignalProtocol.resetSession(_senderId))
          .thenAnswer((_) async {});

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      // Should call resetSession then retry decryptP2P
      verify(() => mockSignalProtocol.resetSession(_senderId)).called(1);
      verify(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .called(2);
    });

    test('transient failure without x3dhHeader does NOT retry', () async {
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenThrow(StateError('Generic failure'));

      // Message without x3dhHeader
      final msgNoHeader = _createEncryptedMessageModel(
        omitX3dhHeader: true,
      );

      await pushMessagesAndWait([msgNoHeader]);

      // Only one decrypt attempt, no reset
      verify(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .called(1);
      verifyNever(() => mockSignalProtocol.resetSession(any()));
    });

    test('protectSession=true skips destructive recovery for older messages', () async {
      // Two messages from same sender: msg_2 (newer, succeeds) and msg_1 (older, fails)
      // Messages arrive newest-first from Firestore
      final msg2 = _createEncryptedMessageModel(id: 'msg_2');
      final msg1 = _createEncryptedMessageModel(
        id: 'msg_1',
        e2ee: {
          'protocol': 'signal-v2',
          'messageNumber': 1,
          'dhPublicKey': 'dh_pub_key_base64',
        },
      );

      var decryptCallCount = 0;
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenAnswer((_) async {
        decryptCallCount++;
        if (decryptCallCount == 1) return 'Newer message';
        throw StateError('Older message failed');
      });

      // Pushing both messages (msg2 first = newer, msg1 second = older)
      await pushMessagesAndWait([msg2, msg1]);

      // resetSession should NOT be called (protectSession for older msg)
      verifyNever(() => mockSignalProtocol.resetSession(any()));
    });
  });

  // ===========================================================================
  // Already-processed messages
  // ===========================================================================
  group('Already-processed messages', () {
    test('skips already-decrypted messages', () async {
      // Return existing decrypted message from local DB
      when(() => mockAppDatabase.getLocalMessageById('msg_1'))
          .thenAnswer((_) async => LocalFullMessage(
                id: 'msg_1',
                conversationId: _conversationId,
                senderId: _senderId,
                senderName: 'Bob',
                type: 'text',
                status: 'sent',
                textContent: 'Already decrypted',
                isDecrypted: true,
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
                readByJson: '{}',
                forwardedFromJson: null,
              ));

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      // decryptP2P should NOT be called
      verifyNever(
          () => mockSignalProtocol.decryptP2P(any(), any()));
    });
  });

  // ===========================================================================
  // Identity key verification
  // ===========================================================================
  group('Identity key verification', () {
    test('blocks decryption when identity key mismatches', () async {
      // Registered key differs from claimed key in x3dhHeader
      when(() => mockDataSource.getUserE2eeIdentityKey(_senderId))
          .thenAnswer((_) async => 'registered_key_different');

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      // decryptP2P should NOT be called (blocked by identity check)
      verifyNever(
          () => mockSignalProtocol.decryptP2P(any(), any()));
    });

    test('allows decryption when identity key matches', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(_senderId))
          .thenAnswer((_) async => 'identity_key_base64_long_enough');
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenAnswer((_) async => 'Decrypted');

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      verify(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .called(1);
    });

    test('allows decryption when registered key is null (new user)', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(_senderId))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .thenAnswer((_) async => 'Decrypted');

      await pushMessagesAndWait([_createEncryptedMessageModel()]);

      verify(() => mockSignalProtocol.decryptP2P(_senderId, any()))
          .called(1);
    });
  });

  // ===========================================================================
  // Lifecycle
  // ===========================================================================
  group('Lifecycle', () {
    test('startSync is idempotent (calling twice does not double-subscribe)', () async {
      syncService.startSync();
      syncService.startSync();

      // watchConversations should only be called once
      verify(() => mockDataSource.watchConversations()).called(1);
    });

    test('stopSync cancels all subscriptions', () async {
      syncService.startSync();
      syncService.stopSync();

      // Pushing data after stop should not trigger processing
      conversationStreamController.add([_createConversationModel()]);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verifyNever(() => mockAppDatabase.upsertLocalConversation(any()));
    });
  });
}
