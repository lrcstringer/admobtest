import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/repositories/community_repository.dart';
import 'package:imalichat/presentation/blocs/community_messaging/community_messaging_bloc.dart';

import '../../helpers/e2ee_test_helpers.dart';

class MockCommunityRepository extends Mock implements CommunityRepository {}

void main() {
  late MockCommunityRepository mockCommunityRepository;

  const testCommunityId = E2EETestData.testCommunityId;

  // Test fixtures
  final plaintextMessage = E2EETestData.createPlaintextMessage();
  final encryptedMessage = E2EETestData.createEncryptedMessage(
    id: 'msg_encrypted',
    senderId: E2EETestData.testRecipientId,
  );
  final waitingForKeyMessage = E2EETestData.createWaitingForKeyMessage();
  final sentMessage = E2EETestData.createPlaintextMessage(
    id: 'msg_sent',
    senderId: E2EETestData.testUserId,
    textContent: 'Sent to community',
  );

  CommunityMessagingBloc createBloc() => CommunityMessagingBloc(
        mockCommunityRepository,
        communityId: testCommunityId,
      );

  setUp(() {
    mockCommunityRepository = MockCommunityRepository();

    // Default stubs for streams that may be triggered
    when(() => mockCommunityRepository.watchMessages(
          communityId: any(named: 'communityId'),
          limit: any(named: 'limit'),
        )).thenAnswer((_) => const Stream.empty());
  });

  group('CommunityMessagingBloc - E2EE Message Handling', () {
    // =========================================================================
    // Initial state
    // =========================================================================

    test('initial state is correct', () {
      final bloc = createBloc();
      expect(bloc.state.communityId, testCommunityId);
      expect(bloc.state.messages, isEmpty);
      expect(bloc.state.isLoading, false);
      expect(bloc.state.isSending, false);
      bloc.close();
    });

    // =========================================================================
    // loadMessages
    // =========================================================================

    group('loadMessages', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits [isLoading=true, loaded with messages] when loadMessages succeeds',
        build: () {
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer(
            (_) async => Right([plaintextMessage, encryptedMessage]),
          );
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.messages.length, 'messages.length', 2),
        ],
      );

      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits error when loadMessages fails',
        build: () {
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // =========================================================================
    // sendTextMessage
    // =========================================================================

    group('sendTextMessage', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'calls repository.sendTextMessage and emits sending states',
        build: () {
          when(() => mockCommunityRepository.sendTextMessage(
                communityId: any(named: 'communityId'),
                text: any(named: 'text'),
                replyToMessageId: any(named: 'replyToMessageId'),
              )).thenAnswer((_) async => Right(sentMessage));
          return createBloc();
        },
        act: (bloc) => bloc.add(const CommunityMessagingEvent.sendTextMessage(
          text: 'Hello community!',
        )),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', false),
        ],
        verify: (_) {
          verify(() => mockCommunityRepository.sendTextMessage(
                communityId: testCommunityId,
                text: 'Hello community!',
                replyToMessageId: null,
              )).called(1);
        },
      );

      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits error on send failure',
        build: () {
          when(() => mockCommunityRepository.sendTextMessage(
                communityId: any(named: 'communityId'),
                text: any(named: 'text'),
                replyToMessageId: any(named: 'replyToMessageId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) => bloc.add(const CommunityMessagingEvent.sendTextMessage(
          text: 'This will fail',
        )),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // =========================================================================
    // watchMessages
    // =========================================================================

    group('watchMessages', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits decrypted messages from stream via messagesUpdated',
        build: () {
          final streamController =
              StreamController<Either<Failure, List<Message>>>();
          when(() => mockCommunityRepository.watchMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) => streamController.stream);

          // Emit messages after a short delay
          Future.delayed(const Duration(milliseconds: 50), () {
            streamController.add(
                Right([plaintextMessage, waitingForKeyMessage]));
          });

          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const CommunityMessagingEvent.watchMessages());
          await Future.delayed(const Duration(milliseconds: 150));
        },
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.messages.length, 'messages.length', 2)
              .having(
                (s) => s.messages.any((m) =>
                    m.textContent == '[Waiting for encryption key...]'),
                'has waiting-for-key message',
                true,
              ),
        ],
      );
    });

    // =========================================================================
    // Messages with E2EE decryption states
    // =========================================================================

    group('messages with E2EE decryption states', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'messages with [Waiting for encryption key...] appear in state',
        build: () {
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer(
            (_) async =>
                Right([plaintextMessage, waitingForKeyMessage]),
          );
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.messages.length, 'messages.length', 2)
              .having(
                (s) => s.messages.any((m) =>
                    m.textContent == '[Waiting for encryption key...]'),
                'has waiting-for-key message',
                true,
              )
              .having(
                (s) => s.messages
                    .any((m) => m.e2ee?.protocol == 'sender-key-v2'),
                'has sender-key protocol metadata',
                true,
              ),
        ],
      );

      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'mixed encrypted and plaintext messages in loaded state',
        build: () {
          final mixedMessages = [
            plaintextMessage,
            encryptedMessage,
            waitingForKeyMessage,
            E2EETestData.createSystemMessage(),
          ];
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer((_) async => Right(mixedMessages));
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.messages.length, 'messages.length', 4)
              .having(
                (s) => s.messages.where((m) => m.isEncrypted).length,
                'encrypted message count',
                2,
              )
              .having(
                (s) => s.messages
                    .where((m) => m.isTextMessage)
                    .length,
                'text message count',
                3,
              ),
        ],
      );
    });
  });
}
