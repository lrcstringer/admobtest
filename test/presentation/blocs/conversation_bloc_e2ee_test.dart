import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/conversation_repository.dart';
import 'package:imalichat/presentation/blocs/conversation/conversation_bloc.dart';

import '../../helpers/e2ee_test_helpers.dart';

class MockConversationRepository extends Mock
    implements ConversationRepository {}

void main() {
  late MockConversationRepository mockConversationRepository;

  // Test fixtures
  final plaintextMessage = E2EETestData.createPlaintextMessage();
  final encryptedMessage = E2EETestData.createEncryptedMessage(
    id: 'msg_encrypted',
    senderId: E2EETestData.testRecipientId,
  );
  final decryptionFailedMessage = E2EETestData.createDecryptionFailedMessage();
  final sentMessage = E2EETestData.createPlaintextMessage(
    id: 'msg_sent',
    senderId: E2EETestData.testUserId,
    textContent: 'Sent message',
  );
  final tokenSendMessage = E2EETestData.createTokenSendMessage();

  setUp(() {
    mockConversationRepository = MockConversationRepository();

    // Default stubs for streams that may be triggered
    when(() => mockConversationRepository.watchConversations())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockConversationRepository.watchTotalUnreadCount())
        .thenAnswer((_) => const Stream.empty());
  });

  group('ConversationBloc - E2EE Message Handling', () {
    // =========================================================================
    // loadMessages
    // =========================================================================

    group('loadMessages', () {
      blocTest<ConversationBloc, ConversationState>(
        'emits [isLoadingMessages=true, loaded with messages] when loadMessages succeeds',
        build: () {
          when(() => mockConversationRepository.getMessages(
                conversationId: any(named: 'conversationId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer(
              (_) async => Right([plaintextMessage, encryptedMessage]),
            );
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.loadMessages(
          conversationId: 'conv_abc',
        )),
        expect: () => [
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.messages.length, 'messages.length', 2),
        ],
      );

      blocTest<ConversationBloc, ConversationState>(
        'emits empty messages list when no messages exist',
        build: () {
          when(() => mockConversationRepository.getMessages(
                conversationId: any(named: 'conversationId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer((_) async => const Right([]));
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.loadMessages(
          conversationId: 'conv_abc',
        )),
        expect: () => [
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.messages, 'messages', isEmpty),
        ],
      );

      blocTest<ConversationBloc, ConversationState>(
        'emits error when loadMessages fails',
        build: () {
          when(() => mockConversationRepository.getMessages(
                conversationId: any(named: 'conversationId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.loadMessages(
          conversationId: 'conv_abc',
        )),
        expect: () => [
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // =========================================================================
    // Messages with decryption failures
    // =========================================================================

    group('messages with E2EE decryption states', () {
      blocTest<ConversationBloc, ConversationState>(
        'messages with [Cannot decrypt] appear correctly in state',
        build: () {
          when(() => mockConversationRepository.getMessages(
                conversationId: any(named: 'conversationId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer(
              (_) async => Right([plaintextMessage, decryptionFailedMessage]),
            );
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.loadMessages(
          conversationId: 'conv_abc',
        )),
        expect: () => [
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.messages.length, 'messages.length', 2)
              .having(
                (s) => s.messages
                    .any((m) => m.textContent == '[Cannot decrypt]'),
                'has decrypt-failed message',
                true,
              )
              .having(
                (s) => s.messages.any((m) => m.ciphertext != null),
                'has message with ciphertext',
                true,
              ),
        ],
      );

      blocTest<ConversationBloc, ConversationState>(
        'mixed encrypted and plaintext messages in loaded state',
        build: () {
          final mixedMessages = [
            plaintextMessage,
            encryptedMessage,
            E2EETestData.createSystemMessage(),
            tokenSendMessage,
          ];
          when(() => mockConversationRepository.getMessages(
                conversationId: any(named: 'conversationId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer((_) async => Right(mixedMessages));
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.loadMessages(
          conversationId: 'conv_abc',
        )),
        expect: () => [
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ConversationState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.messages.length, 'messages.length', 4)
              .having(
                (s) => s.messages.where((m) => m.isEncrypted).length,
                'encrypted count',
                1,
              )
              .having(
                (s) => s.messages.where((m) => m.isTextMessage).length,
                'text message count',
                2,
              ),
        ],
      );
    });

    // =========================================================================
    // sendTextMessage
    // =========================================================================

    group('sendTextMessage', () {
      blocTest<ConversationBloc, ConversationState>(
        'calls repository.sendTextMessage — no BLoC state change on success '
        '(optimistic insert done by OutgoingMessageQueue into local DB)',
        build: () {
          when(() => mockConversationRepository.sendTextMessage(
                conversationId: any(named: 'conversationId'),
                text: any(named: 'text'),
                replyToMessageId: any(named: 'replyToMessageId'),
                recipientId: any(named: 'recipientId'),
              )).thenAnswer((_) async => Right(sentMessage));
          when(() => mockConversationRepository.currentUserId)
              .thenReturn('test_user');
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.sendTextMessage(
          conversationId: 'conv_abc',
          text: 'Hello encrypted world!',
        )),
        // No BLoC state emissions on success — the optimistic message
        // appears via the local DB watch stream, not via BLoC state.
        expect: () => [],
        verify: (_) {
          verify(() => mockConversationRepository.sendTextMessage(
                conversationId: 'conv_abc',
                text: 'Hello encrypted world!',
                replyToMessageId: null,
                recipientId: null,
              )).called(1);
        },
      );

      blocTest<ConversationBloc, ConversationState>(
        'emits errorMessage when sendTextMessage fails',
        build: () {
          when(() => mockConversationRepository.sendTextMessage(
                conversationId: any(named: 'conversationId'),
                text: any(named: 'text'),
                replyToMessageId: any(named: 'replyToMessageId'),
                recipientId: any(named: 'recipientId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          when(() => mockConversationRepository.currentUserId)
              .thenReturn('test_user');
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.sendTextMessage(
          conversationId: 'conv_abc',
          text: 'This will fail',
        )),
        expect: () => [
          // Only an error message is emitted — failed status is managed
          // by OutgoingMessageQueue in the local DB.
          isA<ConversationState>()
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // markAsRead moved to ConversationActionsBloc

    // =========================================================================
    // requestTokens
    // =========================================================================

    group('requestTokens', () {
      blocTest<ConversationBloc, ConversationState>(
        'calls repository.requestTokens with correct parameters',
        build: () {
          when(() => mockConversationRepository.requestTokens(
                conversationId: any(named: 'conversationId'),
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
              )).thenAnswer((_) async => Right(tokenSendMessage));
          return ConversationBloc(mockConversationRepository);
        },
        act: (bloc) => bloc.add(const ConversationEvent.requestTokens(
          conversationId: 'conv_abc',
          recipientId: 'bob_user_id',
          amount: 500,
          message: 'Please send me tokens',
        )),
        expect: () => [
          isA<ConversationState>()
              .having((s) => s.isSending, 'isSending', true),
          isA<ConversationState>()
              .having((s) => s.isSending, 'isSending', false),
        ],
        verify: (_) {
          verify(() => mockConversationRepository.requestTokens(
                conversationId: 'conv_abc',
                recipientId: 'bob_user_id',
                amount: 500,
                message: 'Please send me tokens',
              )).called(1);
        },
      );
    });
  });
}
