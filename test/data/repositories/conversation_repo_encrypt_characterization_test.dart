// Characterization tests for ConversationRepositoryImpl._encryptWithFreshnessCheck
//
// Captures the exact current behavior of the pre-encrypt and post-encrypt
// freshness checks. These are the regression safety net for the refactoring.

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/conversation_model.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/media_upload_datasource.dart';
import 'package:imalichat/data/repositories/conversation_repository_impl.dart';
import 'package:imalichat/core/services/message_sync_service.dart';
import 'package:imalichat/core/services/offline_action_queue.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

// ==================== MOCKS ====================

class MockConversationRemoteDataSource extends Mock
    implements ConversationRemoteDataSource {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockMediaUploadDatasource extends Mock implements MediaUploadDatasource {}

class MockMessageSyncService extends Mock implements MessageSyncService {}

class MockOfflineActionQueue extends Mock implements OfflineActionQueue {}

// ==================== FIXTURES ====================

const _userId = 'user_1';
const _recipientId = 'user_2';
const _conversationId = 'conv_123';

ConversationModel _createConversationModel() {
  return ConversationModel(
    id: _conversationId,
    type: 'p2p',
    participantIds: [_userId, _recipientId],
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

Map<String, dynamic> _encryptedResult({
  String ciphertext = 'ct_base64',
  int messageNumber = 0,
}) =>
    {
      'ciphertext': ciphertext,
      'e2ee': {'protocol': 'signal-v1', 'messageNumber': messageNumber},
      'x3dhHeader': {
        'identityKey': 'ik',
        'ephemeralKey': 'ek',
      },
    };

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

    // Standard stubs
    when(() => mockDataSource.currentUserId).thenReturn(_userId);
    when(() => mockDataSource.getConversationById(_conversationId))
        .thenAnswer((_) async => _createConversationModel());
    when(() => mockAppDatabase.cacheDecryptedPlaintext(any(), any()))
        .thenAnswer((_) async {});
    when(() => mockAppDatabase.getDecryptedPlaintext(any()))
        .thenAnswer((_) async => null);
    when(() => mockAppDatabase.getLocalConversation(any()))
        .thenAnswer((_) async => null);
    when(() => mockAppDatabase.upsertLocalMessage(any()))
        .thenAnswer((_) async {});
    when(() => mockSyncService.sentPlaintextCache).thenReturn({});
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
  // _encryptWithFreshnessCheck: Pre-encrypt staleness
  // ===========================================================================
  group('Pre-encrypt staleness check', () {
    test('does NOT reset session when peer key matches', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => 'peer_key_abc');
      when(() => mockSignalProtocol.isPeerKeyStale(_recipientId, 'peer_key_abc'))
          .thenAnswer((_) async => false);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      verify(() => mockSignalProtocol.isPeerKeyStale(_recipientId, 'peer_key_abc'))
          .called(1);
      verifyNever(() => mockSignalProtocol.resetSession(_recipientId));
    });

    test('resets session when peer key is stale', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => 'new_peer_key');
      when(() => mockSignalProtocol.isPeerKeyStale(_recipientId, 'new_peer_key'))
          .thenAnswer((_) async => true);
      when(() => mockSignalProtocol.resetSession(_recipientId))
          .thenAnswer((_) async {});
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      verify(() => mockSignalProtocol.resetSession(_recipientId)).called(1);
    });

    test('skips freshness check when getUserE2eeIdentityKey returns null', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      verifyNever(() => mockSignalProtocol.isPeerKeyStale(any(), any()));
    });

    test('freshness check failure is non-fatal (encrypt still proceeds)', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(_recipientId))
          .thenThrow(Exception('Network error'));
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      // Should succeed despite freshness check failure
      expect(result.isRight(), isTrue);
    });
  });

  // ===========================================================================
  // _encryptWithFreshnessCheck: Post-encrypt verification
  // ===========================================================================
  group('Post-encrypt verification', () {
    test('does NOT re-encrypt when key is unchanged', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async => 'same_key');
      when(() => mockSignalProtocol.isPeerKeyStale(_recipientId, 'same_key'))
          .thenAnswer((_) async => false);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      // encryptP2P called exactly once (no re-encrypt)
      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .called(1);
    });

    test('re-encrypts when key changed during encryption', () async {
      // First call returns key_A, second returns key_B
      // Keys must be >= 8 chars (code logs substring(0,8))
      var callCount = 0;
      when(() => mockDataSource.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async {
        callCount++;
        return callCount <= 1
            ? 'key_AAAA_original'
            : 'key_BBBB_changed_!';
      });
      when(() => mockSignalProtocol.isPeerKeyStale(
            _recipientId, 'key_AAAA_original'))
          .thenAnswer((_) async => false);
      when(() => mockSignalProtocol.resetSession(_recipientId))
          .thenAnswer((_) async {});
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      // encryptP2P called TWICE (original + re-encrypt)
      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .called(2);
      // resetSession called for re-encrypt
      verify(() => mockSignalProtocol.resetSession(_recipientId)).called(1);
    });

    test('post-encrypt check failure is non-fatal (original ciphertext used)', () async {
      // Pre-encrypt returns key, post-encrypt throws
      var callCount = 0;
      when(() => mockDataSource.getUserE2eeIdentityKey(_recipientId))
          .thenAnswer((_) async {
        callCount++;
        if (callCount <= 1) return 'key_AAAA_original';
        throw Exception('Network error on post-check');
      });
      when(() => mockSignalProtocol.isPeerKeyStale(
            _recipientId, 'key_AAAA_original'))
          .thenAnswer((_) async => false);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult(ciphertext: 'original_ct'));
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      expect(result.isRight(), isTrue);
      // Original encrypted message sent (only one encrypt call)
      verify(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .called(1);
    });
  });

  // ===========================================================================
  // Plaintext caching
  // ===========================================================================
  group('Plaintext caching', () {
    test('pre-caches plaintext by ciphertext fingerprint before sending', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(any()))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult(ciphertext: 'abcdef123456'));
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      // Verify ciphertext fingerprint cache was called
      verify(() => mockAppDatabase.cacheDecryptedPlaintext(
            'sent_ct:abcdef123456', // fingerprint of ciphertext
            'Hello',
          )).called(1);
    });

    test('caches plaintext in sync service by messageId after send', () async {
      String? cachedId;
      String? cachedText;
      when(() => mockSyncService.cacheSentPlaintext(any(), any()))
          .thenAnswer((invocation) {
        cachedId = invocation.positionalArguments[0] as String;
        cachedText = invocation.positionalArguments[1] as String;
      });
      when(() => mockDataSource.getUserE2eeIdentityKey(any()))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenAnswer((_) async => _encryptedResult());
      when(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      expect(cachedId, equals('msg_001'));
      expect(cachedText, equals('Hello'));
    });
  });

  // ===========================================================================
  // Error handling
  // ===========================================================================
  group('Error handling', () {
    test('returns Left when unauthenticated', () async {
      when(() => mockDataSource.currentUserId).thenReturn(null);

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      expect(result.isLeft(), isTrue);
    });

    test('returns Left when encryption fails', () async {
      when(() => mockDataSource.getUserE2eeIdentityKey(any()))
          .thenAnswer((_) async => null);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Hello'))
          .thenThrow(StateError('No session'));

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      expect(result.isLeft(), isTrue);
    });

    test('returns Left when recipient cannot be determined', () async {
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => null);

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
      );

      expect(result.isLeft(), isTrue);
    });
  });
}
