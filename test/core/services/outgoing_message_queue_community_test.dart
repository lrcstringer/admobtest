import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/core/services/media_recovery_service.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/core/services/sender_key_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/data/datasources/remote/community_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/data/models/community_member_model.dart';
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

    queue = OutgoingMessageQueue(
      mockDb,
      mockNetworkInfo,
      mockConversationDS,
      mockCommunityDS,
      mockSignalProtocol,
      mockSenderKey,
      mockMessageSync,
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
        )).thenAnswer((_) async {});
    when(() => mockDb.getPendingMessages())
        .thenAnswer((_) async => []);

    // Message sync — void
    when(() => mockMessageSync.cacheSentPlaintext(any(), any()))
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
      verify(() => mockDb.incrementPendingMessageRetry(expiredRetryMsg.id))
          .called(1);
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
      verify(() => mockDb.updatePendingMessageStatus(msg.id, 'pending'))
          .called(1);

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
              msg.id, 'pending'))
          .called(1);
    });
  });

  // ===========================================================================
  // 8. Vault storage retry — retries up to 3 times
  // ===========================================================================

  group('vault storage retry', () {
    test('vault storePayload retries up to 3 times on failure', () async {
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
          )).thenAnswer((_) async => 'real_msg_id');

      // Vault fails all 3 times
      when(() => mockMediaRecovery.storePayload(any(), any()))
          .thenThrow(Exception('Vault unavailable'));

      await queue.processPendingMessages();

      // storePayload should have been called 3 times (retry loop in _finalizeSent)
      verify(() => mockMediaRecovery.storePayload('real_msg_id', 'Hello vault'))
          .called(3);

      // Despite vault failure, the message should still finalize successfully
      verify(() => mockDb.deletePendingMessage(msg.id)).called(1);
    });

    test('vault storePayload succeeds on second attempt', () async {
      final msg = _makePendingMessage(
        type: 'community_text',
        plaintext: 'Retry success',
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
          )).thenAnswer((_) async => 'real_msg_2');

      // Vault fails first time, succeeds second time
      var callCount = 0;
      when(() => mockMediaRecovery.storePayload(any(), any()))
          .thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw Exception('Temporary vault error');
        }
        // Second call succeeds
      });

      await queue.processPendingMessages();

      // storePayload called exactly 2 times (fail + succeed)
      verify(() =>
              mockMediaRecovery.storePayload('real_msg_2', 'Retry success'))
          .called(2);
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
          .thenAnswer((_) async {});

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
          .thenAnswer((_) async {});
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
}
