import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/data/models/conversation_model.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/data/datasources/remote/media_upload_datasource.dart';
import 'package:imalichat/data/repositories/conversation_repository_impl.dart';
import 'package:imalichat/core/services/offline_action_queue.dart';
import 'package:imalichat/core/services/outgoing_message_queue.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/data/datasources/local/app_database.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockConversationRemoteDataSource extends Mock
    implements ConversationRemoteDataSource {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockMediaUploadDatasource extends Mock implements MediaUploadDatasource {}

class MockOfflineActionQueue extends Mock implements OfflineActionQueue {}

class MockOutgoingMessageQueue extends Mock implements OutgoingMessageQueue {}

// ==================== TEST FIXTURES ====================

const _userId = 'user_1';
const _recipientId = 'user_2';
const _conversationId = 'conv_123';

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
    readByJson: '{}',
    forwardedFromJson: null,
  );
}

/// Creates a LocalFullConversation row for testing getConversations()
LocalFullConversation _createLocalFullConversation({
  String id = _conversationId,
  String type = 'p2p',
  String? lastMessageText = 'Hello!',
  String recipientId = _recipientId,
}) {
  return LocalFullConversation(
    id: id,
    type: type,
    participantIdsJson: '["$_userId","$recipientId"]',
    participantsJson:
        '{"$_userId":{"displayName":"Alice"},"$recipientId":{"displayName":"Bob"}}',
    lastMessageId: 'msg_1',
    lastMessageText: lastMessageText,
    lastMessageSenderId: _userId,
    lastMessageSenderName: 'Alice',
    lastMessageType: 'text',
    lastMessageAt: DateTime(2024, 6, 1, 12, 0),
    unreadCountsJson: '{"$_userId":0,"$_recipientId":1}',
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
  late MockAppDatabase mockAppDatabase;
  late MockOfflineActionQueue mockOfflineQueue;
  late MockOutgoingMessageQueue mockOutgoingQueue;
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
    mockAppDatabase = MockAppDatabase();
    mockOfflineQueue = MockOfflineActionQueue();
    mockOutgoingQueue = MockOutgoingMessageQueue();
    // Stub getLocalConversation to return null by default (Firestore fallback)
    when(() => mockAppDatabase.getLocalConversation(any()))
        .thenAnswer((_) async => null);
    // Stub currentUserId — most send methods check this
    when(() => mockDataSource.currentUserId).thenReturn(_userId);
    // Stub offline queue enqueue (returns Future<void>)
    when(() => mockOfflineQueue.enqueue(
          table: any(named: 'table'),
          recordId: any(named: 'recordId'),
          changeType: any(named: 'changeType'),
          data: any(named: 'data'),
        )).thenAnswer((_) async {});
    repository = ConversationRepositoryImpl(
      mockDataSource,
      mockAppDatabase,
      MockMediaUploadDatasource(),
      mockOfflineQueue,
      mockOutgoingQueue,
    );
  });

  // ===========================================================================
  // sendTextMessage — now delegates to OutgoingMessageQueue
  // ===========================================================================

  group('sendTextMessage', () {
    test('enqueues text message via OutgoingMessageQueue', () async {
      final localConv = _createLocalFullConversation();
      when(() => mockAppDatabase.getLocalConversation(_conversationId))
          .thenAnswer((_) async => localConv);
      when(() => mockOutgoingQueue.enqueueTextMessage(
            conversationId: _conversationId,
            text: 'Hi',
            recipientId: _recipientId,
            replyToMessageId: null,
          )).thenAnswer((_) async => Message(
            id: 'pending_123',
            senderId: _userId,
            senderName: '',
            type: MessageType.text,
            status: MessageStatus.sending,
            textContent: 'Hi',
            createdAt: DateTime.now(),
          ));

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hi',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (message) {
          expect(message.textContent, 'Hi');
          expect(message.status, MessageStatus.sending);
        },
      );
      verify(() => mockOutgoingQueue.enqueueTextMessage(
            conversationId: _conversationId,
            text: 'Hi',
            recipientId: _recipientId,
            replyToMessageId: null,
          )).called(1);
    });

    test('uses provided recipientId directly (skips local DB lookup)',
        () async {
      when(() => mockOutgoingQueue.enqueueTextMessage(
            conversationId: _conversationId,
            text: 'Hello',
            recipientId: _recipientId,
            replyToMessageId: null,
          )).thenAnswer((_) async => Message(
            id: 'pending_456',
            senderId: _userId,
            senderName: '',
            type: MessageType.text,
            status: MessageStatus.sending,
            textContent: 'Hello',
            createdAt: DateTime.now(),
          ));

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Hello',
        recipientId: _recipientId,
      );

      expect(result.isRight(), isTrue);
      // Should NOT have looked up local conversation
      verifyNever(() => mockAppDatabase.getLocalConversation(_conversationId));
    });

    test('returns Left(serverError) when recipient cannot be determined',
        () async {
      when(() => mockAppDatabase.getLocalConversation(_conversationId))
          .thenAnswer((_) async => null);

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result.isLeft(), isTrue);
    });

    test('returns Left(unauthenticated) when currentUserId is null', () async {
      when(() => mockDataSource.currentUserId).thenReturn(null);

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('passes replyToMessageId through to queue', () async {
      when(() => mockOutgoingQueue.enqueueTextMessage(
            conversationId: _conversationId,
            text: 'Reply',
            recipientId: _recipientId,
            replyToMessageId: 'parent_msg',
          )).thenAnswer((_) async => Message(
            id: 'pending_789',
            senderId: _userId,
            senderName: '',
            type: MessageType.text,
            status: MessageStatus.sending,
            textContent: 'Reply',
            createdAt: DateTime.now(),
          ));

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Reply',
        recipientId: _recipientId,
        replyToMessageId: 'parent_msg',
      );

      verify(() => mockOutgoingQueue.enqueueTextMessage(
            conversationId: _conversationId,
            text: 'Reply',
            recipientId: _recipientId,
            replyToMessageId: 'parent_msg',
          )).called(1);
    });
  });

  // ===========================================================================
  // getConversations — reads from local DB (offline-first)
  // ===========================================================================

  group('getConversations', () {
    test('reads conversations from local DB and returns entities', () async {
      when(() => mockAppDatabase.getLocalConversations())
          .thenAnswer((_) async => [
                _createLocalFullConversation(id: 'conv_1'),
                _createLocalFullConversation(
                    id: 'conv_2', recipientId: 'user_3'),
              ]);

      final result = await repository.getConversations();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (conversations) {
          expect(conversations.length, 2);
          expect(conversations[0].id, 'conv_1');
          expect(conversations[1].id, 'conv_2');
        },
      );
    });

    test('returns empty list when no local conversations', () async {
      when(() => mockAppDatabase.getLocalConversations())
          .thenAnswer((_) async => []);

      final result = await repository.getConversations();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (conversations) => expect(conversations.isEmpty, isTrue),
      );
    });

    test('returns Left on database error', () async {
      when(() => mockAppDatabase.getLocalConversations())
          .thenThrow(Exception('DB error'));

      final result = await repository.getConversations();

      expect(result.isLeft(), isTrue);
    });
  });

  // ===========================================================================
  // getMessages — reads from local DB (pre-decrypted by MessageSyncService)
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
  // watchMessages — streams from local DB (pre-decrypted)
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
  });

  // ===========================================================================
  // Metadata operations — routed through OfflineActionQueue
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
    test('returns from local DB when found (offline-first)', () async {
      final localRow = _createLocalFullConversation();
      when(() => mockAppDatabase.getLocalConversation(_conversationId))
          .thenAnswer((_) async => localRow);

      final result = await repository.getConversationById(_conversationId);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (conv) {
          expect(conv.id, _conversationId);
          expect(conv.participantIds, [_userId, _recipientId]);
        },
      );
      // Firestore should NOT be called when local DB has the data
      verifyNever(() => mockDataSource.getConversationById(any()));
    });

    test('falls back to Firestore when not in local DB', () async {
      when(() => mockAppDatabase.getLocalConversation(_conversationId))
          .thenAnswer((_) async => null);
      final model = ConversationModel(
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
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => model);

      final result = await repository.getConversationById(_conversationId);

      expect(result.isRight(), isTrue);
      verify(() => mockDataSource.getConversationById(_conversationId))
          .called(1);
    });

    test('returns Left(serverError) when neither local DB nor Firestore has it',
        () async {
      when(() => mockAppDatabase.getLocalConversation('not_found'))
          .thenAnswer((_) async => null);
      when(() => mockDataSource.getConversationById('not_found'))
          .thenAnswer((_) async => null);

      final result = await repository.getConversationById('not_found');

      expect(result.isLeft(), isTrue);
    });
  });

  group('sendTokens', () {
    test('enqueues token send via OutgoingMessageQueue', () async {
      when(() => mockOutgoingQueue.enqueueTokenSend(
            conversationId: _conversationId,
            recipientId: _recipientId,
            amount: 100,
            message: 'Enjoy!',
          )).thenAnswer((_) async => Message(
            id: 'pending_tok_1',
            senderId: _userId,
            senderName: '',
            type: MessageType.tokenSend,
            status: MessageStatus.sending,
            tokenAmount: 100,
            textContent: 'Enjoy!',
            createdAt: DateTime.now(),
          ));

      final result = await repository.sendTokens(
        conversationId: _conversationId,
        recipientId: _recipientId,
        amount: 100,
        message: 'Enjoy!',
      );

      expect(result.isRight(), isTrue);
      verify(() => mockOutgoingQueue.enqueueTokenSend(
            conversationId: _conversationId,
            recipientId: _recipientId,
            amount: 100,
            message: 'Enjoy!',
          )).called(1);
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
    test('computes unread count from local DB conversations', () async {
      when(() => mockAppDatabase.getLocalConversations())
          .thenAnswer((_) async => [
                _createLocalFullConversation(id: 'conv_1'),
                _createLocalFullConversation(id: 'conv_2'),
              ]);

      final result = await repository.getTotalUnreadCount();

      // Both conversations have unreadCounts {"user_1": 0, "user_2": 1}
      // For user_1, unread count is 0 + 0 = 0
      expect(result, const Right(0));
    });
  });

  group('retryMessage', () {
    test('delegates to OutgoingMessageQueue', () async {
      when(() => mockOutgoingQueue.retryMessage('pending_123'))
          .thenAnswer((_) async {});

      final result = await repository.retryMessage('pending_123');

      expect(result, const Right(null));
      verify(() => mockOutgoingQueue.retryMessage('pending_123')).called(1);
    });
  });
}
