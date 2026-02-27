// Characterization tests for OutgoingMessageQueue._encryptWithFreshnessCheck
//
// These tests were originally on ConversationRepositoryImpl, but the logic
// moved to OutgoingMessageQueue as part of the offline-first refactoring.
// They capture the exact behavior of the pre-encrypt and post-encrypt
// freshness checks — the regression safety net for the refactoring.

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/core/services/sender_key_service.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/data/datasources/remote/community_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

// ==================== MOCKS ====================

class MockAppDatabase extends Mock implements AppDatabase {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockConversationRemoteDataSource extends Mock
    implements ConversationRemoteDataSource {}

class MockCommunityRemoteDataSource extends Mock
    implements CommunityRemoteDataSource {}

class MockSenderKeyService extends Mock implements SenderKeyService {}

class MockMessageSyncService extends Mock implements MessageSyncService {}

// ==================== FIXTURES ====================

const _recipientId = 'user_2';
const _conversationId = 'conv_123';
const _pendingId = 'pending_test_001';

Map<String, dynamic> _encryptedResult({
  String ciphertext = 'ct_base64',
  int messageNumber = 0,
}) =>
    {
      'ciphertext': ciphertext,
      'e2ee': {'protocol': 'signal-v2', 'messageNumber': messageNumber},
      'x3dhHeader': {
        'identityKey': 'ik',
        'ephemeralKey': 'ek',
      },
    };

/// Creates a fake LocalPendingMessage for processing.
LocalPendingMessage _createPendingTextMessage({
  String id = _pendingId,
  String plaintext = 'Hello',
  String recipientId = _recipientId,
  String conversationId = _conversationId,
}) =>
    LocalPendingMessage(
      id: id,
      conversationId: conversationId,
      type: 'text',
      plaintext: plaintext,
      recipientId: recipientId,
      replyToMessageId: null,
      payloadJson: null,
      status: 'pending',
      errorMessage: null,
      retryCount: 0,
      createdAt: DateTime(2024, 6, 1),
      lastAttemptAt: null,
    );

// ==================== TESTS ====================

void main() {
  late MockAppDatabase mockAppDatabase;
  late MockNetworkInfo mockNetworkInfo;
  late MockConversationRemoteDataSource mockConversationDS;
  late MockCommunityRemoteDataSource mockCommunityDS;
  late MockSignalProtocolService mockSignalProtocol;
  late MockSenderKeyService mockSenderKeyService;
  late MockMessageSyncService mockSyncService;
  late OutgoingMessageQueue queue;

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
    registerFallbackValue(LocalPendingMessagesCompanion.insert(
      id: '',
      conversationId: '',
      type: '',
      status: '',
      createdAt: DateTime(2024),
    ));
  });

  setUp(() {
    mockAppDatabase = MockAppDatabase();
    mockNetworkInfo = MockNetworkInfo();
    mockConversationDS = MockConversationRemoteDataSource();
    mockCommunityDS = MockCommunityRemoteDataSource();
    mockSignalProtocol = MockSignalProtocolService();
    mockSenderKeyService = MockSenderKeyService();
    mockSyncService = MockMessageSyncService();

    // Standard stubs
    when(() => mockAppDatabase.updatePendingMessageStatus(any(), any(),
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt')))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.cacheDecryptedPlaintext(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.deleteLocalMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.upsertLocalMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.deletePendingMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.incrementPendingMessageRetry(any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.updateLocalMessageStatus(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockConversationDS.currentUserId).thenReturn('user_1');
    when(() => mockSyncService.cacheSentPlaintext(any(), any())).thenReturn(null);

    // Pending messages: return our test message
    when(() => mockAppDatabase.getPendingMessages())
        .thenAnswer((_) async => [_createPendingTextMessage()]);

    queue = OutgoingMessageQueue(
      mockAppDatabase,
      mockNetworkInfo,
      mockConversationDS,
      mockCommunityDS,
      mockSignalProtocol,
      mockSenderKeyService,
      mockSyncService,
    );
  });

  // ===========================================================================
  // _encryptWithFreshnessCheck: Pre-encrypt staleness
  // ===========================================================================
  group('Pre-encrypt staleness check', () {
    test('does NOT reset session when peer key matches', () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => 'peer_key_abc');
      when(() =>
              mockSignalProtocol.isPeerKeyStale(_recipientId, 'peer_key_abc'))
          .thenAnswer((_) async => false);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      verify(() =>
              mockSignalProtocol.isPeerKeyStale(_recipientId, 'peer_key_abc'))
          .called(1);
      verifyNever(() => mockSignalProtocol.resetSession(_recipientId));
    });

    test('resets session when peer key is stale', () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => 'new_peer_key');
      when(() =>
              mockSignalProtocol.isPeerKeyStale(_recipientId, 'new_peer_key'))
          .thenAnswer((_) async => true);
      when(() => mockSignalProtocol.resetSession(_recipientId))
          .thenAnswer((_) async {});
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      verify(() => mockSignalProtocol.resetSession(_recipientId)).called(1);
    });

    test('skips freshness check when getUserE2eeIdentityKey returns null',
        () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      verifyNever(() => mockSignalProtocol.isPeerKeyStale(any(), any()));
    });

    test('freshness check failure is non-fatal (encrypt still proceeds)',
        () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .thenThrow(Exception('Network error'));
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      // Should complete without throwing
      await queue.processPendingMessages();

      // Encryption proceeded despite freshness check failure
      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .called(1);
      // Message was sent
      verify(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).called(1);
    });
  });

  // ===========================================================================
  // _encryptWithFreshnessCheck: Post-encrypt verification
  // ===========================================================================
  group('Post-encrypt verification', () {
    test('does NOT re-encrypt when key is unchanged', () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => 'same_key');
      when(() => mockSignalProtocol.isPeerKeyStale(_recipientId, 'same_key'))
          .thenAnswer((_) async => false);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      // encryptP2P called exactly once (no re-encrypt)
      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .called(1);
    });

    test('skips post-encrypt check when encryption completes quickly (< 5s)',
        () async {
      // Even if the key changes, the post-encrypt check is skipped for fast
      // encryption (Gap 4 optimization: avoids redundant network call).
      var callCount = 0;
      when(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async {
        callCount++;
        return callCount <= 1 ? 'key_AAAA_original' : 'key_BBBB_changed_!';
      });
      when(() => mockSignalProtocol.isPeerKeyStale(
              _recipientId, 'key_AAAA_original'))
          .thenAnswer((_) async => false);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      // encryptP2P called once (post-encrypt check skipped for fast encryption)
      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .called(1);
      // getUserE2eeIdentityKey called once (pre-encrypt only)
      verify(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .called(1);
    });

    test(
        'post-encrypt check is skipped entirely for fast encryption',
        () async {
      // Since encryption completes instantly in tests (< 5s threshold),
      // the post-encrypt network call is never made, even if it would fail.
      when(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => 'key_AAAA_original');
      when(() => mockSignalProtocol.isPeerKeyStale(
              _recipientId, 'key_AAAA_original'))
          .thenAnswer((_) async => false);
      when(() =>
              mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer(
              (_) async => _encryptedResult(ciphertext: 'original_ct'));
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      // Only one call to getUserE2eeIdentityKey (pre-encrypt only)
      verify(() => mockConversationDS.getUserE2eeIdentityKey(_recipientId))
          .called(1);
      // Original encrypted message sent
      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .called(1);
      verify(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).called(1);
    });
  });

  // ===========================================================================
  // Plaintext caching
  // ===========================================================================
  group('Plaintext caching', () {
    test('pre-caches plaintext by ciphertext fingerprint before sending',
        () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(any()))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer(
              (_) async => _encryptedResult(ciphertext: 'abcdef123456'));
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      // Verify ciphertext fingerprint cache was called
      verify(() => mockAppDatabase.cacheDecryptedPlaintext(
            'sent_ct:abcdef123456', // fingerprint of ciphertext
            'Hello',
          )).called(1);
    });

    test('caches plaintext in sync service by messageId after send', () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(any()))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockConversationDS.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await queue.processPendingMessages();

      verify(() => mockSyncService.cacheSentPlaintext('msg_001', 'Hello'))
          .called(1);
    });
  });

  // ===========================================================================
  // Error handling
  // ===========================================================================
  group('Error handling', () {
    test('marks message failed when encryption fails', () async {
      when(() => mockConversationDS.getUserE2eeIdentityKey(any()))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenThrow(StateError('No session'));

      await queue.processPendingMessages();

      // Message marked as failed
      verify(() => mockAppDatabase.updatePendingMessageStatus(
            _pendingId,
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);
    });

    test('marks message failed when missing plaintext', () async {
      // Override pending messages to return one with null plaintext
      when(() => mockAppDatabase.getPendingMessages()).thenAnswer(
          (_) async => [
                LocalPendingMessage(
                  id: _pendingId,
                  conversationId: _conversationId,
                  type: 'text',
                  plaintext: null,
                  recipientId: _recipientId,
                  replyToMessageId: null,
                  payloadJson: null,
                  status: 'pending',
                  errorMessage: null,
                  retryCount: 0,
                  createdAt: DateTime(2024, 6, 1),
                  lastAttemptAt: null,
                ),
              ]);

      await queue.processPendingMessages();

      verify(() => mockAppDatabase.updatePendingMessageStatus(
            _pendingId,
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);
    });

    test('marks message failed when missing recipientId', () async {
      when(() => mockAppDatabase.getPendingMessages()).thenAnswer(
          (_) async => [
                LocalPendingMessage(
                  id: _pendingId,
                  conversationId: _conversationId,
                  type: 'text',
                  plaintext: 'Hello',
                  recipientId: null,
                  replyToMessageId: null,
                  payloadJson: null,
                  status: 'pending',
                  errorMessage: null,
                  retryCount: 0,
                  createdAt: DateTime(2024, 6, 1),
                  lastAttemptAt: null,
                ),
              ]);

      await queue.processPendingMessages();

      verify(() => mockAppDatabase.updatePendingMessageStatus(
            _pendingId,
            'failed',
            error: any(named: 'error'),
            lastAttemptAt: any(named: 'lastAttemptAt'),
          )).called(1);
    });
  });
}
