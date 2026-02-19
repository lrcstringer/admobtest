import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/data/models/conversation_model.dart';
import 'package:imalichat/data/models/message_model.dart';
import 'package:imalichat/data/datasources/remote/conversation_remote_datasource.dart';
import 'package:imalichat/data/repositories/conversation_repository_impl.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

// ==================== MOCKS ====================

class MockConversationRemoteDataSource extends Mock
    implements ConversationRemoteDataSource {}

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

MessageModel _createEncryptedModel({
  String id = 'msg_enc_1',
  String senderId = _recipientId,
}) {
  return MessageModel(
    id: id,
    senderId: senderId,
    senderName: 'Bob',
    type: 'text',
    status: 'sent',
    textContent: null,
    ciphertext: 'ZW5jcnlwdGVkRGF0YQ==',
    e2ee: {
      'protocol': 'signal-v1',
      'messageNumber': 0,
      'dhPublicKey': 'ZGhQdWJsaWNLZXk=',
    },
    createdAt: DateTime(2024, 6, 1, 12, 0),
  );
}

MessageModel _createEncryptedModelWithX3dh({
  String id = 'msg_enc_x3dh',
  String senderId = _recipientId,
}) {
  return MessageModel(
    id: id,
    senderId: senderId,
    senderName: 'Bob',
    type: 'text',
    status: 'sent',
    textContent: null,
    ciphertext: 'ZW5jcnlwdGVkRGF0YQ==',
    e2ee: {
      'protocol': 'signal-v1',
      'messageNumber': 0,
      'dhPublicKey': 'ZGhQdWJsaWNLZXk=',
    },
    x3dhHeader: {
      'identityKey': 'aWRlbnRpdHlLZXk=',
      'ephemeralKey': 'ZXBoZW1lcmFsS2V5',
      'oneTimePreKeyId': 0,
    },
    createdAt: DateTime(2024, 6, 1, 12, 0),
  );
}

// ==================== TESTS ====================

void main() {
  late MockConversationRemoteDataSource mockDataSource;
  late MockSignalProtocolService mockSignalProtocol;
  late ConversationRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockConversationRemoteDataSource();
    mockSignalProtocol = MockSignalProtocolService();
    repository = ConversationRepositoryImpl(mockDataSource, mockSignalProtocol);
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

    test('falls back to plaintext when encryptP2P throws', () async {
      final convModel = _createConversationModel();
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => convModel);
      when(() => mockSignalProtocol.encryptP2P(_recipientId, 'Fallback'))
          .thenThrow(StateError('No session'));
      when(() => mockDataSource.sendTextMessage(
            conversationId: _conversationId,
            text: 'Fallback',
            replyToMessageId: null,
          )).thenAnswer((_) async => _createPlaintextModel());

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Fallback',
      );

      expect(result.isRight(), isTrue);
      verify(() => mockDataSource.sendTextMessage(
            conversationId: _conversationId,
            text: 'Fallback',
            replyToMessageId: null,
          )).called(1);
      verifyNever(() => mockDataSource.sendEncryptedMessage(
            conversationId: any(named: 'conversationId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            x3dhHeader: any(named: 'x3dhHeader'),
            replyToMessageId: any(named: 'replyToMessageId'),
          ));
    });

    test('falls back to plaintext when getConversationById returns null',
        () async {
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => null);
      when(() => mockDataSource.sendTextMessage(
            conversationId: _conversationId,
            text: 'Test',
            replyToMessageId: null,
          )).thenAnswer((_) async => _createPlaintextModel());

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result.isRight(), isTrue);
      verifyNever(
          () => mockSignalProtocol.encryptP2P(any(), any()));
    });

    test('passes correct conversationId to datasource', () async {
      const customConvId = 'conv_custom_999';
      when(() => mockDataSource.getConversationById(customConvId))
          .thenAnswer((_) async => null);
      when(() => mockDataSource.sendTextMessage(
            conversationId: customConvId,
            text: 'Msg',
            replyToMessageId: null,
          )).thenAnswer((_) async => _createPlaintextModel());

      await repository.sendTextMessage(
        conversationId: customConvId,
        text: 'Msg',
      );

      verify(() => mockDataSource.sendTextMessage(
            conversationId: customConvId,
            text: 'Msg',
            replyToMessageId: null,
          )).called(1);
    });

    test('passes replyToMessageId through to datasource', () async {
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => null);
      when(() => mockDataSource.sendTextMessage(
            conversationId: _conversationId,
            text: 'Reply text',
            replyToMessageId: 'parent_msg_1',
          )).thenAnswer((_) async => _createPlaintextModel());

      await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Reply text',
        replyToMessageId: 'parent_msg_1',
      );

      verify(() => mockDataSource.sendTextMessage(
            conversationId: _conversationId,
            text: 'Reply text',
            replyToMessageId: 'parent_msg_1',
          )).called(1);
    });

    test('returns Left(unauthenticated) when AuthException is thrown',
        () async {
      // The inner try-catch swallows errors from getConversationById,
      // so AuthException must come from the plaintext fallback path
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => null);
      when(() => mockDataSource.sendTextMessage(
            conversationId: _conversationId,
            text: 'Test',
            replyToMessageId: null,
          )).thenThrow(const AuthException(message: 'Not logged in'));

      final result = await repository.sendTextMessage(
        conversationId: _conversationId,
        text: 'Test',
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) when ServerException is thrown', () async {
      when(() => mockDataSource.getConversationById(_conversationId))
          .thenAnswer((_) async => null);
      when(() => mockDataSource.sendTextMessage(
            conversationId: _conversationId,
            text: 'Test',
            replyToMessageId: null,
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
  // getMessages
  // ===========================================================================

  group('getMessages', () {
    test('decrypts encrypted messages via _decryptIfNeeded', () async {
      when(() => mockDataSource.getMessages(
            conversationId: _conversationId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createEncryptedModel()]);
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenAnswer((_) async => 'Decrypted text');

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Decrypted text');
        },
      );
    });

    test('plaintext messages pass through unchanged', () async {
      when(() => mockDataSource.getMessages(
            conversationId: _conversationId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createPlaintextModel()]);

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Hello, world!');
        },
      );
      verifyNever(
          () => mockSignalProtocol.decryptP2P(any(), any()));
    });

    test('failed decryption results in "[Cannot decrypt]" text', () async {
      when(() => mockDataSource.getMessages(
            conversationId: _conversationId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createEncryptedModel()]);
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenThrow(Exception('Decryption error'));

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, '[Cannot decrypt]');
        },
      );
    });

    test('returns correct list size for mixed messages', () async {
      when(() => mockDataSource.getMessages(
            conversationId: _conversationId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [
            _createPlaintextModel(id: 'msg_1'),
            _createEncryptedModel(id: 'msg_2'),
            _createPlaintextModel(id: 'msg_3', senderId: _recipientId),
          ]);
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenAnswer((_) async => 'Decrypted');

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 3);
          expect(messages[0].textContent, 'Hello, world!');
          expect(messages[1].textContent, 'Decrypted');
          expect(messages[2].textContent, 'Hello, world!');
        },
      );
    });

    test('passes x3dhHeader fields to decryptP2P', () async {
      when(() => mockDataSource.getMessages(
            conversationId: _conversationId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createEncryptedModelWithX3dh()]);
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenAnswer((_) async => 'Session established');

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result.isRight(), isTrue);
      final captured = verify(
              () => mockSignalProtocol.decryptP2P(_recipientId, captureAny()))
          .captured;
      final decryptMap = captured.first as Map<String, dynamic>;
      expect(decryptMap.containsKey('x3dhHeader'), isTrue);
      expect(decryptMap['x3dhHeader']['identityKey'], 'aWRlbnRpdHlLZXk=');
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.getMessages(
            conversationId: _conversationId,
            limit: null,
            before: null,
          )).thenThrow(const AuthException(message: 'Not authed'));

      final result = await repository.getMessages(
        conversationId: _conversationId,
      );

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // ===========================================================================
  // watchMessages
  // ===========================================================================

  group('watchMessages', () {
    test('stream emits decrypted messages via asyncMap', () async {
      when(() => mockDataSource.watchMessages(
            conversationId: _conversationId,
            limit: null,
          )).thenAnswer((_) => Stream.value([_createEncryptedModel()]));
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenAnswer((_) async => 'Watched & decrypted');

      final stream = repository.watchMessages(
        conversationId: _conversationId,
      );

      final emission = await stream.first;
      expect(emission.isRight(), isTrue);
      emission.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Watched & decrypted');
        },
      );
    });

    test('stream handles mixed encrypted and plaintext messages', () async {
      when(() => mockDataSource.watchMessages(
            conversationId: _conversationId,
            limit: null,
          )).thenAnswer((_) => Stream.value([
            _createPlaintextModel(id: 'pt_1'),
            _createEncryptedModel(id: 'enc_1'),
          ]));
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenAnswer((_) async => 'Decrypted stream msg');

      final stream = repository.watchMessages(
        conversationId: _conversationId,
      );

      final emission = await stream.first;
      emission.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 2);
          expect(messages[0].textContent, 'Hello, world!');
          expect(messages[1].textContent, 'Decrypted stream msg');
        },
      );
    });

    test('uses asyncMap for async decryption in stream', () async {
      // Verify the stream uses asyncMap by checking it awaits decryptP2P
      var decryptCalled = false;
      when(() => mockDataSource.watchMessages(
            conversationId: _conversationId,
            limit: null,
          )).thenAnswer((_) => Stream.value([_createEncryptedModel()]));
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenAnswer((_) async {
        decryptCalled = true;
        return 'Async result';
      });

      final stream = repository.watchMessages(
        conversationId: _conversationId,
      );
      await stream.first;

      expect(decryptCalled, isTrue);
    });

    test('decrypt failure in stream results in "[Cannot decrypt]"', () async {
      when(() => mockDataSource.watchMessages(
            conversationId: _conversationId,
            limit: null,
          )).thenAnswer((_) => Stream.value([_createEncryptedModel()]));
      when(() => mockSignalProtocol.decryptP2P(_recipientId, any()))
          .thenThrow(Exception('Stream decrypt error'));

      final stream = repository.watchMessages(
        conversationId: _conversationId,
      );

      final emission = await stream.first;
      emission.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages[0].textContent, '[Cannot decrypt]');
        },
      );
    });
  });

  // ===========================================================================
  // Passthrough methods
  // ===========================================================================

  group('markAsRead', () {
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.markAsRead(conversationId: _conversationId))
          .thenAnswer((_) async {});

      final result = await repository.markAsRead(
        conversationId: _conversationId,
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.markAsRead(conversationId: _conversationId))
          .called(1);
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.markAsRead(conversationId: _conversationId))
          .thenThrow(const AuthException(message: 'No auth'));

      final result = await repository.markAsRead(
        conversationId: _conversationId,
      );

      expect(result, const Left(Failure.unauthenticated()));
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
      when(() => mockDataSource.sendTokens(
            conversationId: _conversationId,
            recipientId: _recipientId,
            amount: 100,
            message: 'Enjoy!',
          )).thenAnswer((_) async => model);

      final result = await repository.sendTokens(
        conversationId: _conversationId,
        recipientId: _recipientId,
        amount: 100,
        message: 'Enjoy!',
      );

      expect(result.isRight(), isTrue);
      verify(() => mockDataSource.sendTokens(
            conversationId: _conversationId,
            recipientId: _recipientId,
            amount: 100,
            message: 'Enjoy!',
          )).called(1);
    });

    test('returns Left(insufficientBalance) on InsufficientBalanceException',
        () async {
      when(() => mockDataSource.sendTokens(
            conversationId: _conversationId,
            recipientId: _recipientId,
            amount: 99999,
            message: null,
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
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.togglePin(
            conversationId: _conversationId,
            pinned: true,
          )).thenAnswer((_) async {});

      final result = await repository.togglePin(
        conversationId: _conversationId,
        pinned: true,
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.togglePin(
            conversationId: _conversationId,
            pinned: true,
          )).called(1);
    });
  });

  group('toggleMute', () {
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.toggleMute(
            conversationId: _conversationId,
            muted: true,
          )).thenAnswer((_) async {});

      final result = await repository.toggleMute(
        conversationId: _conversationId,
        muted: true,
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.toggleMute(
            conversationId: _conversationId,
            muted: true,
          )).called(1);
    });
  });

  group('archiveConversation', () {
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.archiveConversation(_conversationId))
          .thenAnswer((_) async {});

      final result =
          await repository.archiveConversation(_conversationId);

      expect(result, const Right(null));
      verify(() => mockDataSource.archiveConversation(_conversationId))
          .called(1);
    });
  });

  group('addReaction', () {
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.addReaction(
            conversationId: _conversationId,
            messageId: 'msg_1',
            emoji: '👍',
          )).thenAnswer((_) async {});

      final result = await repository.addReaction(
        conversationId: _conversationId,
        messageId: 'msg_1',
        emoji: '👍',
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.addReaction(
            conversationId: _conversationId,
            messageId: 'msg_1',
            emoji: '👍',
          )).called(1);
    });
  });

  group('removeReaction', () {
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.removeReaction(
            conversationId: _conversationId,
            messageId: 'msg_1',
            emoji: '👍',
          )).thenAnswer((_) async {});

      final result = await repository.removeReaction(
        conversationId: _conversationId,
        messageId: 'msg_1',
        emoji: '👍',
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.removeReaction(
            conversationId: _conversationId,
            messageId: 'msg_1',
            emoji: '👍',
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
