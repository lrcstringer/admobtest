import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/error/exceptions.dart';
import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/core/network/network_info.dart';
import 'package:imalichat/data/datasources/remote/community_remote_datasource.dart';
import 'package:imalichat/data/models/community_model.dart';
import 'package:imalichat/data/models/community_member_model.dart';
import 'package:imalichat/data/models/message_model.dart';
import 'package:imalichat/data/repositories/community_repository_impl.dart';
import 'package:imalichat/domain/enums/community_type.dart';
import 'package:imalichat/domain/enums/member_role.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:imalichat/domain/repositories/community_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/e2ee_test_helpers.dart';

// ==================== MOCKS ====================

class MockCommunityRemoteDataSource extends Mock
    implements CommunityRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

// ==================== FALLBACK VALUES ====================

class FakeCreateCommunityParams extends Fake
    implements CreateCommunityParams {}

class FakeUpdateCommunityParams extends Fake
    implements UpdateCommunityParams {}

// ==================== TEST FIXTURES ====================

const _userId = 'user_1';
const _recipientId = 'user_2';
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
    memberIds: [_userId, _recipientId],
    adminIds: [_userId],
    memberCount: 2,
    status: 'active',
    settings: const CommunitySettingsModel(),
    createdAt: DateTime(2024, 6, 1),
  );
}

CommunityMemberModel _createMemberModel({
  String id = _userId,
  String communityId = _communityId,
}) {
  return CommunityMemberModel(
    id: id,
    communityId: communityId,
    userId: id,
    displayName: 'Alice',
    role: 'owner',
    status: 'active',
    invitedBy: _userId,
    invitedAt: DateTime(2024, 6, 1),
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
    textContent: 'Hello, community!',
    communityId: _communityId,
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
      'protocol': 'sender-key-v1',
      'senderKeyChainId': 'chain_abc',
      'messageNumber': 0,
    },
    communityId: _communityId,
    createdAt: DateTime(2024, 6, 1, 12, 0),
  );
}

// ==================== TESTS ====================

void main() {
  late MockCommunityRemoteDataSource mockDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockSenderKeyService mockSenderKeyService;
  late CommunityRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeCreateCommunityParams());
    registerFallbackValue(FakeUpdateCommunityParams());
    registerFallbackValue(MemberRole.member);
  });

  setUp(() {
    mockDataSource = MockCommunityRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockSenderKeyService = MockSenderKeyService();
    repository = CommunityRepositoryImpl(
      mockDataSource,
      mockNetworkInfo,
      mockSenderKeyService,
    );
  });

  // ===========================================================================
  // sendTextMessage
  // ===========================================================================

  group('sendTextMessage', () {
    test('calls encryptCommunity with communityId and plaintext', () async {
      when(() => mockSenderKeyService.encryptCommunity(
              _communityId, 'Hello'))
          .thenAnswer((_) async => {
                'ciphertext': 'sk_encrypted',
                'e2ee': {
                  'protocol': 'sender-key-v1',
                  'senderKeyChainId': 'chain_1',
                  'messageNumber': 0,
                },
              });
      when(() => mockDataSource.sendEncryptedCommunityMessage(
            communityId: _communityId,
            ciphertext: 'sk_encrypted',
            e2ee: {
              'protocol': 'sender-key-v1',
              'senderKeyChainId': 'chain_1',
              'messageNumber': 0,
            },
            replyToMessageId: null,
          )).thenAnswer((_) async => 'msg_001');

      await repository.sendTextMessage(
        communityId: _communityId,
        text: 'Hello',
      );

      verify(() => mockSenderKeyService.encryptCommunity(
          _communityId, 'Hello')).called(1);
    });

    test(
        'sends encrypted community message to datasource on encryption success',
        () async {
      when(() =>
              mockSenderKeyService.encryptCommunity(_communityId, 'Hi all'))
          .thenAnswer((_) async => {
                'ciphertext': 'ct_data',
                'e2ee': {
                  'protocol': 'sender-key-v1',
                  'senderKeyChainId': 'chain_2',
                  'messageNumber': 5,
                },
              });
      when(() => mockDataSource.sendEncryptedCommunityMessage(
            communityId: _communityId,
            ciphertext: 'ct_data',
            e2ee: {
              'protocol': 'sender-key-v1',
              'senderKeyChainId': 'chain_2',
              'messageNumber': 5,
            },
            replyToMessageId: null,
          )).thenAnswer((_) async => 'msg_002');

      final result = await repository.sendTextMessage(
        communityId: _communityId,
        text: 'Hi all',
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (message) {
          expect(message.textContent, 'Hi all');
          expect(message.communityId, _communityId);
          expect(message.type, MessageType.text);
          expect(message.status, MessageStatus.sent);
        },
      );
      verify(() => mockDataSource.sendEncryptedCommunityMessage(
            communityId: _communityId,
            ciphertext: 'ct_data',
            e2ee: {
              'protocol': 'sender-key-v1',
              'senderKeyChainId': 'chain_2',
              'messageNumber': 5,
            },
            replyToMessageId: null,
          )).called(1);
    });

    test('falls back to plaintext when encryptCommunity throws', () async {
      when(() => mockSenderKeyService.encryptCommunity(
              _communityId, 'Fallback'))
          .thenThrow(StateError('No sender key'));
      when(() => mockDataSource.sendTextMessage(
            communityId: _communityId,
            text: 'Fallback',
            replyToMessageId: null,
          )).thenAnswer((_) async => _createPlaintextModel());

      final result = await repository.sendTextMessage(
        communityId: _communityId,
        text: 'Fallback',
      );

      expect(result.isRight(), isTrue);
      verify(() => mockDataSource.sendTextMessage(
            communityId: _communityId,
            text: 'Fallback',
            replyToMessageId: null,
          )).called(1);
      verifyNever(() => mockDataSource.sendEncryptedCommunityMessage(
            communityId: any(named: 'communityId'),
            ciphertext: any(named: 'ciphertext'),
            e2ee: any(named: 'e2ee'),
            replyToMessageId: any(named: 'replyToMessageId'),
          ));
    });

    test('passes correct communityId to datasource', () async {
      const customCommunityId = 'community_custom_456';
      when(() => mockSenderKeyService.encryptCommunity(
              customCommunityId, 'Msg'))
          .thenThrow(Exception('No key'));
      when(() => mockDataSource.sendTextMessage(
            communityId: customCommunityId,
            text: 'Msg',
            replyToMessageId: null,
          )).thenAnswer((_) async => _createPlaintextModel());

      await repository.sendTextMessage(
        communityId: customCommunityId,
        text: 'Msg',
      );

      verify(() => mockDataSource.sendTextMessage(
            communityId: customCommunityId,
            text: 'Msg',
            replyToMessageId: null,
          )).called(1);
    });

    test('returns Left(unauthenticated) when AuthException is thrown',
        () async {
      // The inner try-catch swallows encryption errors,
      // so AuthException must come from the plaintext fallback path
      when(() => mockSenderKeyService.encryptCommunity(any(), any()))
          .thenThrow(Exception('Encrypt fail'));
      when(() => mockDataSource.sendTextMessage(
            communityId: _communityId,
            text: 'Test',
            replyToMessageId: null,
          )).thenThrow(const AuthException(message: 'No auth'));

      final result = await repository.sendTextMessage(
        communityId: _communityId,
        text: 'Test',
      );

      expect(result, const Left(Failure.unauthenticated()));
    });

    test('returns Left(serverError) when ServerException is thrown', () async {
      when(() =>
              mockSenderKeyService.encryptCommunity(_communityId, 'Test'))
          .thenThrow(Exception('Encrypt fail'));
      when(() => mockDataSource.sendTextMessage(
            communityId: _communityId,
            text: 'Test',
            replyToMessageId: null,
          )).thenThrow(const ServerException(message: 'Server down'));

      final result = await repository.sendTextMessage(
        communityId: _communityId,
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
            communityId: _communityId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createEncryptedModel()]);
      when(() => mockSenderKeyService.decryptCommunity(
              _communityId, _recipientId, any()))
          .thenAnswer((_) async => 'Decrypted community text');

      final result = await repository.getMessages(
        communityId: _communityId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Decrypted community text');
        },
      );
    });

    test('StateError results in "[Waiting for encryption key...]"', () async {
      when(() => mockDataSource.getMessages(
            communityId: _communityId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createEncryptedModel()]);
      when(() => mockSenderKeyService.decryptCommunity(
              _communityId, _recipientId, any()))
          .thenThrow(StateError('No sender key for user'));

      final result = await repository.getMessages(
        communityId: _communityId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent,
              '[Waiting for encryption key...]');
        },
      );
    });

    test('other errors result in "[Cannot decrypt]"', () async {
      when(() => mockDataSource.getMessages(
            communityId: _communityId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createEncryptedModel()]);
      when(() => mockSenderKeyService.decryptCommunity(
              _communityId, _recipientId, any()))
          .thenThrow(Exception('Unknown decrypt error'));

      final result = await repository.getMessages(
        communityId: _communityId,
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

    test('plaintext messages pass through unchanged', () async {
      when(() => mockDataSource.getMessages(
            communityId: _communityId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [_createPlaintextModel()]);

      final result = await repository.getMessages(
        communityId: _communityId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 1);
          expect(messages[0].textContent, 'Hello, community!');
        },
      );
      verifyNever(() => mockSenderKeyService.decryptCommunity(
          any(), any(), any()));
    });

    test('returns correct list size for mixed messages', () async {
      when(() => mockDataSource.getMessages(
            communityId: _communityId,
            limit: null,
            before: null,
          )).thenAnswer((_) async => [
            _createPlaintextModel(id: 'pt_1'),
            _createEncryptedModel(id: 'enc_1'),
            _createPlaintextModel(id: 'pt_2', senderId: _recipientId),
          ]);
      when(() => mockSenderKeyService.decryptCommunity(
              _communityId, _recipientId, any()))
          .thenAnswer((_) async => 'Decrypted');

      final result = await repository.getMessages(
        communityId: _communityId,
      );

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 3);
          expect(messages[0].textContent, 'Hello, community!');
          expect(messages[1].textContent, 'Decrypted');
          expect(messages[2].textContent, 'Hello, community!');
        },
      );
    });

    test('returns Left(unauthenticated) on AuthException', () async {
      when(() => mockDataSource.getMessages(
            communityId: _communityId,
            limit: null,
            before: null,
          )).thenThrow(const AuthException(message: 'Not authed'));

      final result = await repository.getMessages(
        communityId: _communityId,
      );

      expect(result, const Left(Failure.unauthenticated()));
    });
  });

  // ===========================================================================
  // watchMessages
  // ===========================================================================

  group('watchMessages', () {
    test('stream decrypts via asyncMap', () async {
      when(() => mockDataSource.watchMessages(
            communityId: _communityId,
            limit: null,
          )).thenAnswer((_) => Stream.value([_createEncryptedModel()]));
      when(() => mockSenderKeyService.decryptCommunity(
              _communityId, _recipientId, any()))
          .thenAnswer((_) async => 'Watched & decrypted');

      final stream = repository.watchMessages(
        communityId: _communityId,
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

    test('StateError in stream results in "[Waiting for encryption key...]"',
        () async {
      when(() => mockDataSource.watchMessages(
            communityId: _communityId,
            limit: null,
          )).thenAnswer((_) => Stream.value([_createEncryptedModel()]));
      when(() => mockSenderKeyService.decryptCommunity(
              _communityId, _recipientId, any()))
          .thenThrow(StateError('No sender key'));

      final stream = repository.watchMessages(
        communityId: _communityId,
      );

      final emission = await stream.first;
      emission.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages[0].textContent,
              '[Waiting for encryption key...]');
        },
      );
    });

    test('stream handles mixed encrypted and plaintext messages', () async {
      when(() => mockDataSource.watchMessages(
            communityId: _communityId,
            limit: null,
          )).thenAnswer((_) => Stream.value([
            _createPlaintextModel(id: 'pt_1'),
            _createEncryptedModel(id: 'enc_1'),
          ]));
      when(() => mockSenderKeyService.decryptCommunity(
              _communityId, _recipientId, any()))
          .thenAnswer((_) async => 'Decrypted stream msg');

      final stream = repository.watchMessages(
        communityId: _communityId,
      );

      final emission = await stream.first;
      emission.fold(
        (_) => fail('Expected Right'),
        (messages) {
          expect(messages.length, 2);
          expect(messages[0].textContent, 'Hello, community!');
          expect(messages[1].textContent, 'Decrypted stream msg');
        },
      );
    });
  });

  // ===========================================================================
  // Passthrough methods
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

      final result = await repository.createCommunity(params);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (community) {
          expect(community.id, _communityId);
          expect(community.name, 'Test Community');
        },
      );
    });

    test('returns Left(network) when not connected', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);

      final result = await repository.createCommunity(
        CreateCommunityParams(
          type: CommunityType.regular,
          name: 'Test',
        ),
      );

      expect(result, const Left(Failure.network()));
      verifyNever(() => mockDataSource.createCommunity(any()));
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
      verify(() => mockDataSource.leaveCommunity(_communityId))
          .called(1);
    });

    test('returns Left(network) when not connected', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);

      final result = await repository.leaveCommunity(_communityId);

      expect(result, const Left(Failure.network()));
    });
  });

  group('getMembers', () {
    test('delegates to datasource and returns member entities', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.getMembers(_communityId))
          .thenAnswer((_) async => [_createMemberModel()]);

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

    test('returns Left(network) when not connected', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);

      final result = await repository.getMembers(_communityId);

      expect(result, const Left(Failure.network()));
    });
  });

  group('inviteMember', () {
    test('delegates to datasource with correct params', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.inviteMember(
              _communityId, _recipientId, MemberRole.member))
          .thenAnswer((_) async {});

      final result = await repository.inviteMember(
        _communityId,
        _recipientId,
        MemberRole.member,
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.inviteMember(
            _communityId,
            _recipientId,
            MemberRole.member,
          )).called(1);
    });
  });

  group('addReaction', () {
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.addReaction(
            communityId: _communityId,
            messageId: 'msg_1',
            emoji: '🎉',
          )).thenAnswer((_) async {});

      final result = await repository.addReaction(
        communityId: _communityId,
        messageId: 'msg_1',
        emoji: '🎉',
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.addReaction(
            communityId: _communityId,
            messageId: 'msg_1',
            emoji: '🎉',
          )).called(1);
    });
  });

  group('removeReaction', () {
    test('delegates to datasource correctly', () async {
      when(() => mockDataSource.removeReaction(
            communityId: _communityId,
            messageId: 'msg_1',
            emoji: '🎉',
          )).thenAnswer((_) async {});

      final result = await repository.removeReaction(
        communityId: _communityId,
        messageId: 'msg_1',
        emoji: '🎉',
      );

      expect(result, const Right(null));
      verify(() => mockDataSource.removeReaction(
            communityId: _communityId,
            messageId: 'msg_1',
            emoji: '🎉',
          )).called(1);
    });
  });

  group('getCommunity', () {
    test('delegates to datasource and returns entity', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.getCommunity(_communityId))
          .thenAnswer((_) async => _createCommunityModel());

      final result = await repository.getCommunity(_communityId);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right'),
        (community) {
          expect(community.id, _communityId);
          expect(community.name, 'Test Community');
        },
      );
    });

    test('returns Left(serverError) when community not found', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.getCommunity('not_found'))
          .thenAnswer((_) async => null);

      final result = await repository.getCommunity('not_found');

      expect(result.isLeft(), isTrue);
    });
  });

  group('deleteCommunity', () {
    test('delegates to datasource correctly when connected', () async {
      when(() => mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
      when(() => mockDataSource.deleteCommunity(_communityId))
          .thenAnswer((_) async {});

      final result = await repository.deleteCommunity(_communityId);

      expect(result, const Right(null));
      verify(() => mockDataSource.deleteCommunity(_communityId)).called(1);
    });
  });
}
