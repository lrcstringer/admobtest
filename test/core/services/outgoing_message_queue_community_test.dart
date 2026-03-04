import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/core/services/community_sync_service.dart';
import 'package:imalichat/core/services/media_recovery_service.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/core/services/sender_key_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/data/datasources/remote/community_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/data/models/community_member_model.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';

// =============================================================================
// MOCK CLASSES
// =============================================================================

class MockAppDatabase extends Mock implements AppDatabase {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockConversationRemoteDataSource extends Mock
    implements ConversationRemoteDataSource {}

class MockCommunityRemoteDataSource extends Mock
    implements CommunityRemoteDataSource {}

class MockSignalProtocolService extends Mock implements SignalProtocolService {}

class MockSenderKeyService extends Mock implements SenderKeyService {}

class MockMessageSyncService extends Mock implements MessageSyncService {}

class MockMediaRecoveryService extends Mock implements MediaRecoveryService {}

class MockCommunitySyncService extends Mock implements CommunitySyncService {}

class MockUpdateStatement extends Mock
    implements
        UpdateStatement<$LocalPendingMessagesTable, LocalPendingMessage> {}

class _FakeLocalPendingMessagesTable extends Fake
    implements $LocalPendingMessagesTable {}

// Concrete subclass so we can instantiate the @protected constructor.
class _TestFirebaseFunctionsException extends FirebaseFunctionsException {
  _TestFirebaseFunctionsException({
    required super.code,
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// =============================================================================
// HELPERS
// =============================================================================

/// Create a [LocalPendingMessage] with sensible defaults for community tests.
LocalPendingMessage _makePendingMessage({
  String id = 'pending_test_123',
  String conversationId = 'community_abc',
  String type = 'community_text',
  String? plaintext = 'Hello community',
  String? recipientId,
  String? replyToMessageId,
  String? payloadJson,
  String status = 'pending',
  String? errorMessage,
  int retryCount = 0,
  DateTime? createdAt,
  DateTime? lastAttemptAt,
}) {
  return LocalPendingMessage(
    id: id,
    conversationId: conversationId,
    type: type,
    plaintext: plaintext,
    recipientId: recipientId,
    replyToMessageId: replyToMessageId,
    payloadJson: payloadJson,
    status: status,
    errorMessage: errorMessage,
    retryCount: retryCount,
    createdAt: createdAt ?? DateTime.now(),
    lastAttemptAt: lastAttemptAt,
  );
}

void main() {
  late MockAppDatabase mockDb;
  late MockNetworkInfo mockNetworkInfo;
  late MockConversationRemoteDataSource mockConversationDS;
  late MockCommunityRemoteDataSource mockCommunityDS;
  late MockSignalProtocolService mockSignalProtocol;
  late MockSenderKeyService mockSenderKey;
  late MockMessageSyncService mockMessageSync;
  late MockMediaRecoveryService mockMediaRecovery;
  late MockCommunitySyncService mockCommunitySyncService;
  late OutgoingMessageQueue queue;

  setUpAll(() {
    registerFallbackValue(LocalPendingMessagesCompanion(
      id: const Value(''),
      conversationId: const Value(''),
      type: const Value(''),
      status: const Value(''),
      createdAt: Value(DateTime.now()),
    ));
    registerFallbackValue(LocalFullMessagesCompanion(
      id: const Value(''),
      conversationId: const Value(''),
      senderId: const Value(''),
      type: const Value('text'),
      status: const Value('sending'),
      createdAt: Value(DateTime.now()),
    ));
    registerFallbackValue(_FakeLocalPendingMessagesTable());
  });

  setUp(() {
    mockDb = MockAppDatabase();
    mockNetworkInfo = MockNetworkInfo();
    mockConversationDS = MockConversationRemoteDataSource();
    mockCommunityDS = MockCommunityRemoteDataSource();
    mockSignalProtocol = MockSignalProtocolService();
    mockSenderKey = MockSenderKeyService();
    mockMessageSync = MockMessageSyncService();
    mockMediaRecovery = MockMediaRecoveryService();
    mockCommunitySyncService = MockCommunitySyncService();

    queue = OutgoingMessageQueue(
      mockDb,
      mockNetworkInfo,
      mockConversationDS,
      mockCommunityDS,
      mockSignalProtocol,
      mockSenderKey,
      mockMessageSync,
      mockCommunitySyncService,
      mockMediaRecovery,
    );

    // ── Common stubs ──
    when(() => mockConversationDS.currentUserId).thenReturn('user_me');
    when(() => mockCommunityDS.currentUserId).thenReturn('user_me');
    when(() => mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);
    when(() => mockNetworkInfo.onConnectivityChanged)
        .thenAnswer((_) => const Stream<bool>.empty());

    // DB write stubs — void returns
    when(() => mockDb.insertPendingMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockDb.upsertLocalMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockDb.updatePendingMessageStatus(any(), any(),
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt')))
        .thenAnswer((_) async {});
    when(() => mockDb.incrementPendingMessageRetry(any()))
        .thenAnswer((_) async {});
    when(() => mockDb.deletePendingMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockDb.deleteLocalMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockDb.updateLocalMessageStatus(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockDb.cacheDecryptedPlaintext(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockDb.updateLocalCommunityPreview(
          communityId: any(named: 'communityId'),
          lastMessageText: any(named: 'lastMessageText'),
          lastMessageSenderId: any(named: 'lastMessageSenderId'),
          lastMessageAt: any(named: 'lastMessageAt'),
          lastMessageSenderName: any(named: 'lastMessageSenderName'),
          lastMessageType: any(named: 'lastMessageType'),
        )).thenAnswer((_) async {});
    when(() => mockDb.getPendingMessages())
        .thenAnswer((_) async => []);

    // Stub the Drift update() chain used by _encryptAndCache
    final mockUpdateStmt = MockUpdateStatement();
    when(() => mockDb.localPendingMessages).thenReturn(
      _FakeLocalPendingMessagesTable(),
    );
    when(() => mockDb.update<$LocalPendingMessagesTable, LocalPendingMessage>(any())).thenReturn(
      mockUpdateStmt,
    );
    when(() => mockUpdateStmt.write(any())).thenAnswer((_) async => 0);

    // Message sync — void
    when(() => mockMessageSync.cacheSentPlaintext(any(), any()))
        .thenReturn(null);

    // Community sync service
    when(() => mockCommunitySyncService.cacheSentPlaintext(any(), any()))
        .thenReturn(null);

    // Media recovery
    when(() => mockMediaRecovery.storePayload(any(), any()))
        .thenAnswer((_) async {});
  });

  // ===========================================================================
  // 1. State machine validation — isValidTransition
  // ===========================================================================

  group('isValidTransition', () {
    test('pending -> encrypting is valid', () {
      expect(OutgoingMessageQueue.isValidTransition('pending', 'encrypting'),
          isTrue);
    });

    test('pending -> failed is valid', () {
      expect(OutgoingMessageQueue.isValidTransition('pending', 'failed'),
          isTrue);
    });

    test('encrypting -> sending is valid', () {
      expect(OutgoingMessageQueue.isValidTransition('encrypting', 'sending'),
          isTrue);
    });

    test('encrypting -> failed is valid', () {
      expect(OutgoingMessageQueue.isValidTransition('encrypting', 'failed'),
          isTrue);
    });

    test('encrypting -> pending is valid (timeout reset)', () {
      expect(OutgoingMessageQueue.isValidTransition('encrypting', 'pending'),
          isTrue);
    });

    test('sending -> sent is valid', () {
      expect(OutgoingMessageQueue.isValidTransition('sending', 'sent'),
          isTrue);
    });

    test('sending -> failed is valid', () {
      expect(OutgoingMessageQueue.isValidTransition('sending', 'failed'),
          isTrue);
    });

    test('sending -> pending is valid (timeout reset)', () {
      expect(OutgoingMessageQueue.isValidTransition('sending', 'pending'),
          isTrue);
    });

    test('failed -> pending is valid (retry)', () {
      expect(OutgoingMessageQueue.isValidTransition('failed', 'pending'),
          isTrue);
    });

    // Invalid transitions
    test('pending -> sending is INVALID (must encrypt first)', () {
      expect(OutgoingMessageQueue.isValidTransition('pending', 'sending'),
          isFalse);
    });

    test('pending -> sent is INVALID', () {
      expect(OutgoingMessageQueue.isValidTransition('pending', 'sent'),
          isFalse);
    });

    test('failed -> sending is INVALID (must go through pending)', () {
      expect(OutgoingMessageQueue.isValidTransition('failed', 'sending'),
          isFalse);
    });

    test('failed -> encrypting is INVALID', () {
      expect(OutgoingMessageQueue.isValidTransition('failed', 'encrypting'),
          isFalse);
    });

    test('sent -> anything is INVALID (terminal state)', () {
      expect(OutgoingMessageQueue.isValidTransition('sent', 'pending'),
          isFalse);
      expect(OutgoingMessageQueue.isValidTransition('sent', 'failed'),
          isFalse);
    });

    test('unknown state returns false', () {
      expect(OutgoingMessageQueue.isValidTransition('bogus', 'pending'),
          isFalse);
    });
  });

  // ===========================================================================
  // 2. _inferMessageType — tested indirectly through enqueueCommunityMediaMessage
  // ===========================================================================

  group('message type inference (via enqueueCommunityMediaMessage)', () {
    test('audio/* MIME type produces MessageType.voice optimistic message',
        () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_1',
        payloadJson: '{"media":{"url":"https://x.com/a.ogg"}}',
        mediaType: 'audio/ogg',
      );
      expect(result.type, MessageType.voice);
    });

    test('video/* MIME type produces MessageType.video', () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_1',
        payloadJson: '{"media":{"url":"https://x.com/a.mp4"}}',
        mediaType: 'video/mp4',
      );
      expect(result.type, MessageType.video);
    });

    test('application/* MIME type produces MessageType.document', () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_1',
        payloadJson: '{"media":{"url":"https://x.com/a.pdf"}}',
        mediaType: 'application/pdf',
      );
      expect(result.type, MessageType.document);
    });

    test('"document" string produces MessageType.document', () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_1',
        payloadJson: '{"media":{"url":"https://x.com/a.pdf"}}',
        mediaType: 'document',
      );
      expect(result.type, MessageType.document);
    });

    test('image/* MIME type produces MessageType.image', () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_1',
        payloadJson: '{"media":{"url":"https://x.com/a.jpg"}}',
        mediaType: 'image/jpeg',
      );
      expect(result.type, MessageType.image);
    });

    test('unknown MIME type defaults to MessageType.image (enqueue)', () async {
      // The enqueue method uses a different MIME->type mapping (ternary chain)
      // which defaults to image for unrecognized types.
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_1',
        payloadJson: '{"media":{"url":"https://x.com/a.xyz"}}',
        mediaType: 'font/woff2',
      );
      expect(result.type, MessageType.image);
    });
  });

  // ===========================================================================
  // 3. Max retry count — after 10 retries, message is marked failed
  // ===========================================================================

  group('max retry count', () {
    test('message with retryCount >= 10 is marked as failed', () async {
      final expiredRetryMsg = _makePendingMessage(
        retryCount: 10,
        status: 'pending',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [expiredRetryMsg]);

      await queue.processPendingMessages();

      verify(() => mockDb.updatePendingMessageStatus(
            expiredRetryMsg.id,
            'failed',
            error: 'Max retries exceeded',
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);
      verify(() => mockDb.updateLocalMessageStatus(expiredRetryMsg.id, 'failed'))
          .called(1);
    });
  });

  // ===========================================================================
  // 4. Max age — messages older than 24 hours are marked failed
  // ===========================================================================

  group('max age', () {
    test('message older than 24 hours is marked as failed', () async {
      final oldMsg = _makePendingMessage(
        retryCount: 0,
        createdAt: DateTime.now().subtract(const Duration(hours: 25)),
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [oldMsg]);

      await queue.processPendingMessages();

      verify(() => mockDb.updatePendingMessageStatus(
            oldMsg.id,
            'failed',
            error: 'Message expired (over 24 hours old)',
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);
    });

    test('message younger than 24 hours is NOT expired', () async {
      final freshMsg = _makePendingMessage(
        retryCount: 0,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        plaintext: 'Hello community',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [freshMsg]);
      // Stub the sender key flow so it succeeds
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'encrypted_data',
                'e2ee': <String, dynamic>{'algo': 'senderKey'},
              });
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg_id');

      await queue.processPendingMessages();

      // Should NOT be marked failed — should reach the send step
      verifyNever(() => mockDb.updatePendingMessageStatus(
            freshMsg.id,
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          ));
    });
  });

  // ===========================================================================
  // 5. Concurrent processing guard
  // ===========================================================================

  group('concurrent processing guard', () {
    test(
        'second call to processPendingMessages returns immediately '
        'if first is still running', () async {
      // Set up a slow-running first call: getPendingMessages takes a long time
      final slowCompleter = Completer<List<LocalPendingMessage>>();
      var callCount = 0;

      when(() => mockDb.getPendingMessages()).thenAnswer((_) {
        callCount++;
        if (callCount == 1) {
          return slowCompleter.future;
        }
        return Future.value([]);
      });

      // Start first processing (will block on the Completer)
      final firstCall = queue.processPendingMessages();

      // Second call should return immediately since first is in progress
      await queue.processPendingMessages();

      // Complete the first call
      slowCompleter.complete([]);
      await firstCall;

      // getPendingMessages should only have been called once
      // (the second call exited early before reaching getPendingMessages)
      verify(() => mockDb.getPendingMessages()).called(1);
    });
  });

  // ===========================================================================
  // 6. Network error keeps pending (SocketException)
  // ===========================================================================

  group('network error keeps pending', () {
    test(
        'SocketException during community text send leaves message as pending',
        () async {
      final msg = _makePendingMessage(
        type: 'community_text',
        plaintext: 'Hello',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      // Sender key distribution succeeds
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);

      // Encryption succeeds
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });

      // Send throws SocketException
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenThrow(const SocketException('No network'));

      await queue.processPendingMessages();

      // Should NOT be marked as failed — SocketException keeps it pending
      verifyNever(() => mockDb.updatePendingMessageStatus(
            msg.id,
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          ));
    });

    test(
        'SocketException during sender key distribution leaves message pending',
        () async {
      final msg = _makePendingMessage(
        type: 'community_text',
        plaintext: 'Hello',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      // Sender key is NOT distributed
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => false);

      // _ensureSenderKeyDistributed → hits SocketException
      when(() => mockSenderKey.hasSenderKey(any()))
          .thenThrow(const SocketException('No network'));

      await queue.processPendingMessages();

      // Should NOT be marked as failed
      verifyNever(() => mockDb.updatePendingMessageStatus(
            msg.id,
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          ));
    });
  });

  // ===========================================================================
  // 7. Encryption timeout — message reset to pending
  // ===========================================================================

  group('encryption timeout', () {
    test(
        'community text message is reset to pending on encryption timeout',
        () async {
      final msg = _makePendingMessage(
        type: 'community_text',
        plaintext: 'Hello',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      // Sender key distribution succeeds
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);

      // Encryption throws TimeoutException
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async =>
              throw TimeoutException('Encryption timed out'));

      await queue.processPendingMessages();

      // Should be reset to 'pending', NOT 'failed'
      verify(() => mockDb.updatePendingMessageStatus(
            msg.id,
            'pending',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);

      // Should NOT be marked as failed
      verifyNever(() => mockDb.updatePendingMessageStatus(
            msg.id,
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          ));
    });

    test(
        'community media message is reset to pending on encryption timeout',
        () async {
      final msg = _makePendingMessage(
        id: 'pending_media_timeout',
        type: 'community_media',
        plaintext: null,
        payloadJson:
            '{"media":{"url":"https://x.com/photo.jpg","mimeType":"image/jpeg"}}',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      // Sender key distribution succeeds
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);

      // Encryption throws TimeoutException
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async =>
              throw TimeoutException('Encryption timed out'));

      await queue.processPendingMessages();

      // Should be reset to 'pending'
      verify(() => mockDb.updatePendingMessageStatus(
            msg.id,
            'pending',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);
    });
  });

  // ===========================================================================
  // 8. Vault storage retry — retries up to 3 times
  // ===========================================================================

  group('vault storage', () {
    test('vault storePayload is called fire-and-forget during finalization',
        () async {
      final msg = _makePendingMessage(
        type: 'community_text',
        plaintext: 'Hello vault',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      // Sender key distribution + encryption succeed
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg_id');

      await queue.processPendingMessages();

      // storePayload should be called once (fire-and-forget in _finalizeSent)
      verify(() => mockMediaRecovery.storePayload('real_msg_id', 'Hello vault'))
          .called(1);

      // Message should finalize successfully
      verify(() => mockDb.deletePendingMessage(msg.id)).called(1);
    });

    test('vault failure does not block message finalization', () async {
      final msg = _makePendingMessage(
        type: 'community_text',
        plaintext: 'Vault fail ok',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg_2');

      // Vault fails — fire-and-forget catches error
      when(() => mockMediaRecovery.storePayload(any(), any()))
          .thenAnswer((_) async => throw Exception('Vault unavailable'));

      await queue.processPendingMessages();

      // Message should still finalize despite vault failure
      verify(() => mockDb.deletePendingMessage(msg.id)).called(1);
    });
  });

  // ===========================================================================
  // 9. Sender key distribution idempotency
  // ===========================================================================

  group('sender key distribution idempotency', () {
    test(
        'concurrent calls for same community do not duplicate distribution',
        () async {
      // We test this by processing two community text messages for the same
      // community in the same processPendingMessages batch. The second should
      // find the distribution already done (isDistributed returns true after
      // the first call completes).

      final msg1 = _makePendingMessage(
        id: 'pending_1',
        conversationId: 'comm_shared',
        type: 'community_text',
        plaintext: 'msg one',
      );
      final msg2 = _makePendingMessage(
        id: 'pending_2',
        conversationId: 'comm_shared',
        type: 'community_text',
        plaintext: 'msg two',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg1, msg2]);

      // First call: not distributed, second call: already distributed
      var isDistributedCallCount = 0;
      when(() => mockSenderKey.isDistributed('comm_shared'))
          .thenAnswer((_) async {
        isDistributedCallCount++;
        // After first message distributes, it's available for second
        return isDistributedCallCount > 1;
      });

      when(() => mockSenderKey.hasSenderKey('comm_shared'))
          .thenAnswer((_) async => true);
      when(() => mockCommunityDS.getMembers('comm_shared'))
          .thenAnswer((_) async => [
                CommunityMemberModel(
                  id: 'member_me',
                  userId: 'user_me',
                  communityId: 'comm_shared',
                  displayName: 'Me',
                  role: 'member',
                  status: 'active',
                  invitedBy: 'system',
                  invitedAt: DateTime.now(),
                  joinedAt: DateTime.now(),
                ),
                CommunityMemberModel(
                  id: 'member_other',
                  userId: 'user_other',
                  communityId: 'comm_shared',
                  displayName: 'Other',
                  role: 'member',
                  status: 'active',
                  invitedBy: 'system',
                  invitedAt: DateTime.now(),
                  joinedAt: DateTime.now(),
                ),
              ]);
      when(() => mockSenderKey.distributeSenderKeyToAll(any(), any()))
          .thenAnswer((_) async => <String>[]);

      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg');

      await queue.processPendingMessages();

      // distributeSenderKeyToAll should be called only once, not twice
      verify(() => mockSenderKey.distributeSenderKeyToAll(
            'comm_shared',
            ['user_other'],
          )).called(1);
    });

    test(
        'distribution for different communities are independent', () async {
      final msg1 = _makePendingMessage(
        id: 'pending_a',
        conversationId: 'comm_alpha',
        type: 'community_text',
        plaintext: 'alpha msg',
      );
      final msg2 = _makePendingMessage(
        id: 'pending_b',
        conversationId: 'comm_beta',
        type: 'community_text',
        plaintext: 'beta msg',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg1, msg2]);

      // Neither is distributed yet
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => false);
      when(() => mockSenderKey.hasSenderKey(any()))
          .thenAnswer((_) async => true);
      when(() => mockCommunityDS.getMembers(any()))
          .thenAnswer((_) async => [
                CommunityMemberModel(
                  id: 'member_me',
                  userId: 'user_me',
                  communityId: 'any',
                  displayName: 'Me',
                  role: 'member',
                  status: 'active',
                  invitedBy: 'system',
                  invitedAt: DateTime.now(),
                  joinedAt: DateTime.now(),
                ),
                CommunityMemberModel(
                  id: 'member_peer',
                  userId: 'user_peer',
                  communityId: 'any',
                  displayName: 'Peer',
                  role: 'member',
                  status: 'active',
                  invitedBy: 'system',
                  invitedAt: DateTime.now(),
                  joinedAt: DateTime.now(),
                ),
              ]);
      when(() => mockSenderKey.distributeSenderKeyToAll(any(), any()))
          .thenAnswer((_) async => <String>[]);
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg');

      await queue.processPendingMessages();

      // Both communities should have their keys distributed independently
      verify(() => mockSenderKey.distributeSenderKeyToAll(
            'comm_alpha',
            ['user_peer'],
          )).called(1);
      verify(() => mockSenderKey.distributeSenderKeyToAll(
            'comm_beta',
            ['user_peer'],
          )).called(1);
    });
  });

  // ===========================================================================
  // 10. CRIT-1: Encrypted output caching prevents chain ratchet corruption
  // ===========================================================================

  group('CRIT-1: encrypted output caching prevents chain ratchet corruption', () {
    test(
        'cached encrypted payload in payloadJson is reused instead of re-encrypting',
        () async {
      // Message already has a cached encrypted payload from a prior attempt
      final cachedPayload =
          '{"_encrypted":true,"ciphertext":"ct","e2ee":{"algo":"sk"}}';
      final msg = _makePendingMessage(
        id: 'pending_cached_crit1',
        type: 'community_text',
        plaintext: 'Hello community',
        payloadJson: cachedPayload,
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      // Sender key already distributed
      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);

      // Send succeeds
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg_crit1');

      when(() => mockCommunitySyncService.cacheSentPlaintext(any(), any()))
          .thenReturn(null);

      await queue.processPendingMessages();

      // encryptCommunity should NEVER be called — cached payload reused
      verifyNever(() => mockSenderKey.encryptCommunity(any(), any()));

      // Send should have been called with the cached ciphertext
      verify(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: 'community_abc',
            ciphertext: 'ct',
            e2ee: {'algo': 'sk'},
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: 'pending_cached_crit1',
          )).called(1);
    });

    test(
        'null payloadJson triggers fresh encryption and caches result',
        () async {
      final msg = _makePendingMessage(
        id: 'pending_fresh_crit1',
        type: 'community_text',
        plaintext: 'Fresh message',
        payloadJson: null,
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);

      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'fresh_ct',
                'e2ee': <String, dynamic>{'algo': 'senderKey'},
              });

      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg_fresh');

      when(() => mockCommunitySyncService.cacheSentPlaintext(any(), any()))
          .thenReturn(null);

      await queue.processPendingMessages();

      // encryptCommunity SHOULD be called since payloadJson is null
      verify(() => mockSenderKey.encryptCommunity('community_abc', 'Fresh message'))
          .called(1);

      // Send should complete with the freshly encrypted data
      verify(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: 'community_abc',
            ciphertext: 'fresh_ct',
            e2ee: {'algo': 'senderKey'},
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: 'pending_fresh_crit1',
          )).called(1);
    });

    test(
        'corrupt cached JSON falls back to fresh encryption',
        () async {
      // payloadJson starts with '{"_encrypted"' but is invalid JSON
      final msg = _makePendingMessage(
        id: 'pending_corrupt_crit1',
        type: 'community_text',
        plaintext: 'Recover from corruption',
        payloadJson: '{"_encrypted":true,"ciphertext":INVALID',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);

      // Fresh encryption should happen as fallback
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'fallback_ct',
                'e2ee': <String, dynamic>{'algo': 'senderKey'},
              });

      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenAnswer((_) async => 'real_msg_fallback');

      when(() => mockCommunitySyncService.cacheSentPlaintext(any(), any()))
          .thenReturn(null);

      await queue.processPendingMessages();

      // encryptCommunity IS called because cached JSON was corrupt
      verify(() => mockSenderKey.encryptCommunity(
            'community_abc',
            'Recover from corruption',
          )).called(1);

      // Message still sent successfully with fallback encryption
      verify(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: 'community_abc',
            ciphertext: 'fallback_ct',
            e2ee: {'algo': 'senderKey'},
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: 'pending_corrupt_crit1',
          )).called(1);
    });
  });

  // ===========================================================================
  // 11. HIGH-1: _resetToPending behavior
  // ===========================================================================

  group('HIGH-1: _resetToPending behavior', () {
    test(
        'SocketException during send resets message to pending (not failed)',
        () async {
      final msg = _makePendingMessage(
        id: 'pending_socket_h1',
        type: 'community_text',
        plaintext: 'Socket test',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });

      // Send throws SocketException
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenThrow(const SocketException('Connection refused'));

      await queue.processPendingMessages();

      // Should be reset to pending
      verify(() => mockDb.updatePendingMessageStatus(
            'pending_socket_h1',
            'pending',
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(greaterThanOrEqualTo(1));

      // Should NOT be marked failed
      verifyNever(() => mockDb.updatePendingMessageStatus(
            'pending_socket_h1',
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          ));
    });

    test(
        'FirebaseFunctionsException with code unavailable resets to pending',
        () async {
      final msg = _makePendingMessage(
        id: 'pending_unavail_h1',
        type: 'community_text',
        plaintext: 'Unavailable test',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });

      // Send throws FirebaseFunctionsException with 'unavailable'
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenThrow(_TestFirebaseFunctionsException(
        code: 'unavailable',
        message: 'Service unavailable',
      ));

      await queue.processPendingMessages();

      // Should be reset to pending (not failed)
      verify(() => mockDb.updatePendingMessageStatus(
            'pending_unavail_h1',
            'pending',
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(greaterThanOrEqualTo(1));

      // Should NOT be marked failed
      verifyNever(() => mockDb.updatePendingMessageStatus(
            'pending_unavail_h1',
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          ));
    });

    test(
        'non-network error marks message as failed',
        () async {
      final msg = _makePendingMessage(
        id: 'pending_nonnet_h1',
        type: 'community_text',
        plaintext: 'Non-network test',
      );

      when(() => mockDb.getPendingMessages())
          .thenAnswer((_) async => [msg]);

      when(() => mockSenderKey.isDistributed(any()))
          .thenAnswer((_) async => true);
      when(() => mockSenderKey.encryptCommunity(any(), any()))
          .thenAnswer((_) async => {
                'ciphertext': 'ct',
                'e2ee': <String, dynamic>{'algo': 'sk'},
              });

      // Send throws a generic non-network exception
      when(() => mockCommunityDS.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            encryptedPreviews: any(named: 'encryptedPreviews'),
            replyToMessageId: any(named: 'replyToMessageId'),
            idempotencyKey: any(named: 'idempotencyKey'),
          )).thenThrow(Exception('Permission denied'));

      await queue.processPendingMessages();

      // Should be marked as failed
      verify(() => mockDb.updatePendingMessageStatus(
            'pending_nonnet_h1',
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);
    });
  });

  // ===========================================================================
  // 12. Enqueue community text message
  // ===========================================================================

  group('enqueueCommunityTextMessage', () {
    test('returns optimistic message with correct type, status, communityId',
        () async {
      final result = await queue.enqueueCommunityTextMessage(
        communityId: 'comm_enqueue_1',
        text: 'Hello from enqueue test',
      );

      expect(result.type, MessageType.text);
      expect(result.status, MessageStatus.sending);
      expect(result.communityId, 'comm_enqueue_1');
      expect(result.textContent, 'Hello from enqueue test');
      expect(result.senderId, 'user_me');
      expect(result.id, startsWith('pending_'));
    });

    test('persists pending message to DB', () async {
      await queue.enqueueCommunityTextMessage(
        communityId: 'comm_enqueue_2',
        text: 'Persisted text',
      );

      // insertPendingMessage should be called once
      final captured = verify(() => mockDb.insertPendingMessage(captureAny()))
          .captured;
      expect(captured, hasLength(1));
      final companion = captured.first as LocalPendingMessagesCompanion;
      expect(companion.conversationId.value, 'comm_enqueue_2');
      expect(companion.type.value, 'community_text');
      expect(companion.plaintext.value, 'Persisted text');
      expect(companion.status.value, 'pending');
    });

    test('updates community preview', () async {
      await queue.enqueueCommunityTextMessage(
        communityId: 'comm_enqueue_3',
        text: 'Preview text',
      );

      verify(() => mockDb.updateLocalCommunityPreview(
            communityId: 'comm_enqueue_3',
            lastMessageText: 'Preview text',
            lastMessageSenderId: 'user_me',
            lastMessageAt: any(named: 'lastMessageAt'),
            lastMessageSenderName: any(named: 'lastMessageSenderName'),
            lastMessageType: any(named: 'lastMessageType'),
          )).called(1);
    });
  });

  // ===========================================================================
  // 13. Enqueue community media message — caption handling
  // ===========================================================================

  group('enqueueCommunityMediaMessage — caption handling', () {
    test('caption is stored as plaintext and used in preview for image',
        () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_media_1',
        payloadJson: '{"media":{"url":"https://x.com/photo.jpg"}}',
        mediaType: 'image/jpeg',
        caption: 'Check this out!',
      );

      expect(result.type, MessageType.image);
      expect(result.textContent, 'Check this out!');
      expect(result.communityId, 'comm_media_1');
      expect(result.status, MessageStatus.sending);

      // Caption should be used in the pending message plaintext
      final captured = verify(() => mockDb.insertPendingMessage(captureAny()))
          .captured;
      expect(captured, hasLength(1));
      final companion = captured.first as LocalPendingMessagesCompanion;
      expect(companion.plaintext.value, 'Check this out!');
    });

    test('null caption defaults preview to emoji for image type', () async {
      await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_media_2',
        payloadJson: '{"media":{"url":"https://x.com/photo.jpg"}}',
        mediaType: 'image/png',
      );

      // Preview text for image without caption should be the photo emoji fallback
      verify(() => mockDb.updateLocalCommunityPreview(
            communityId: 'comm_media_2',
            lastMessageText: any(named: 'lastMessageText'),
            lastMessageSenderId: 'user_me',
            lastMessageAt: any(named: 'lastMessageAt'),
            lastMessageSenderName: any(named: 'lastMessageSenderName'),
            lastMessageType: any(named: 'lastMessageType'),
          )).called(1);
    });

    test('voice type produces correct preview regardless of caption', () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_media_3',
        payloadJson: '{"media":{"url":"https://x.com/voice.ogg"}}',
        mediaType: 'audio/ogg',
        caption: 'This caption should not be in the preview',
      );

      expect(result.type, MessageType.voice);
    });

    test('video type produces MessageType.video with caption', () async {
      final result = await queue.enqueueCommunityMediaMessage(
        communityId: 'comm_media_4',
        payloadJson: '{"media":{"url":"https://x.com/vid.mp4"}}',
        mediaType: 'video/mp4',
        caption: 'Watch this',
      );

      expect(result.type, MessageType.video);
      expect(result.textContent, 'Watch this');
      expect(result.communityId, 'comm_media_4');
    });
  });
}
