import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/chat_repository.dart';
import 'package:imalichat/presentation/blocs/chat/chat_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockChatRepository;

  setUp(() {
    mockChatRepository = MockChatRepository();
  });

  group('ChatBloc', () {
    test('initial state is correct', () {
      final bloc = ChatBloc(mockChatRepository);
      expect(bloc.state.status, ChatStatus.initial);
      expect(bloc.state.threads, isEmpty);
      expect(bloc.state.messages, isEmpty);
      bloc.close();
    });

    group('LoadThreads', () {
      blocTest<ChatBloc, ChatState>(
        'emits [loading, success] when getChatThreads succeeds',
        build: () {
          when(() => mockChatRepository.getChatThreads())
              .thenAnswer((_) async => Right(TestData.chatThreadList));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.loadThreads()),
        expect: () => [
          isA<ChatState>().having((s) => s.status, 'status', ChatStatus.loading),
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.success)
              .having((s) => s.threads, 'threads', TestData.chatThreadList),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits [loading, failure] when getChatThreads fails',
        build: () {
          when(() => mockChatRepository.getChatThreads())
              .thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.loadThreads()),
        expect: () => [
          isA<ChatState>().having((s) => s.status, 'status', ChatStatus.loading),
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('SelectThread', () {
      blocTest<ChatBloc, ChatState>(
        'selects thread and starts watching messages',
        build: () {
          when(() => mockChatRepository.watchMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) => Stream.value(const Right([])));
          return ChatBloc(mockChatRepository);
        },
        seed: () => ChatState(threads: TestData.chatThreadList),
        act: (bloc) => bloc.add(const ChatEvent.selectThread('thread123')),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.selectedThread?.id, 'selectedThread.id', 'thread123')
              .having((s) => s.messages, 'messages', isEmpty),
        ],
      );
    });

    group('ThreadsUpdated', () {
      blocTest<ChatBloc, ChatState>(
        'updates threads in state',
        build: () => ChatBloc(mockChatRepository),
        act: (bloc) => bloc.add(ChatEvent.threadsUpdated(TestData.chatThreadList)),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.success)
              .having((s) => s.threads, 'threads', TestData.chatThreadList),
        ],
      );
    });

    group('UnreadCountUpdated', () {
      blocTest<ChatBloc, ChatState>(
        'updates total unread count',
        build: () => ChatBloc(mockChatRepository),
        act: (bloc) => bloc.add(const ChatEvent.unreadCountUpdated(5)),
        expect: () => [
          isA<ChatState>().having((s) => s.totalUnreadCount, 'totalUnreadCount', 5),
        ],
      );
    });

    group('SendTextMessage', () {
      blocTest<ChatBloc, ChatState>(
        'emits [sending, sent] when sendTextMessage succeeds',
        build: () {
          when(() => mockChatRepository.sendTextMessage(
                threadId: any(named: 'threadId'),
                text: any(named: 'text'),
              )).thenAnswer((_) async => Right(TestData.textChatCard));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.sendTextMessage(
          threadId: 'thread123',
          text: 'Hello!',
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>().having((s) => s.isSending, 'isSending', false),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when sendTextMessage fails',
        build: () {
          when(() => mockChatRepository.sendTextMessage(
                threadId: any(named: 'threadId'),
                text: any(named: 'text'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.sendTextMessage(
          threadId: 'thread123',
          text: 'Hello!',
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('SendTokens', () {
      blocTest<ChatBloc, ChatState>(
        'sends tokens successfully',
        build: () {
          when(() => mockChatRepository.sendTokens(
                threadId: any(named: 'threadId'),
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
              )).thenAnswer((_) async => Right(TestData.tokenSendCard));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.sendTokens(
          threadId: 'thread123',
          recipientId: 'user456',
          amount: 100,
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>().having((s) => s.isSending, 'isSending', false),
        ],
      );
    });

    group('TogglePinThread', () {
      blocTest<ChatBloc, ChatState>(
        'pins thread successfully',
        build: () {
          when(() => mockChatRepository.togglePinThread(
                threadId: any(named: 'threadId'),
                isPinned: any(named: 'isPinned'),
              )).thenAnswer((_) async => const Right(null));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.togglePinThread(
          threadId: 'thread123',
          isPinned: true,
        )),
        expect: () => [],
        verify: (_) {
          verify(() => mockChatRepository.togglePinThread(
                threadId: 'thread123',
                isPinned: true,
              )).called(1);
        },
      );
    });

    group('ClearError', () {
      blocTest<ChatBloc, ChatState>(
        'clears error message',
        build: () => ChatBloc(mockChatRepository),
        seed: () => const ChatState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const ChatEvent.clearError()),
        expect: () => [
          isA<ChatState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    group('WatchThreads', () {
      blocTest<ChatBloc, ChatState>(
        'subscribes to thread stream and emits threadsUpdated on success',
        build: () {
          when(() => mockChatRepository.watchChatThreads()).thenAnswer(
            (_) => Stream.value(Right(TestData.chatThreadList)),
          );
          when(() => mockChatRepository.watchTotalUnreadCount()).thenAnswer(
            (_) => Stream.value(const Right(3)),
          );
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.watchThreads()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.success)
              .having((s) => s.threads, 'threads', TestData.chatThreadList),
          isA<ChatState>().having((s) => s.totalUnreadCount, 'totalUnreadCount', 3),
        ],
        verify: (_) {
          verify(() => mockChatRepository.watchChatThreads()).called(1);
          verify(() => mockChatRepository.watchTotalUnreadCount()).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'emits clearError when thread stream returns failure',
        build: () {
          when(() => mockChatRepository.watchChatThreads()).thenAnswer(
            (_) => Stream.value(const Left(Failure.network())),
          );
          when(() => mockChatRepository.watchTotalUnreadCount()).thenAnswer(
            (_) => const Stream.empty(),
          );
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.watchThreads()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          // clearError event sets errorMessage to null (no-op from initial state)
          isA<ChatState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });

    group('LoadMessages', () {
      blocTest<ChatBloc, ChatState>(
        'emits loading then messages on success (first page)',
        build: () {
          when(() => mockChatRepository.getMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right(TestData.chatCardList));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.loadMessages(
          threadId: 'thread123',
          limit: 50,
        )),
        expect: () => [
          isA<ChatState>().having(
              (s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ChatState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.messages, 'messages', TestData.chatCardList)
              .having((s) => s.hasMoreMessages, 'hasMoreMessages', false),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'appends messages on pagination (startAfter provided)',
        build: () {
          when(() => mockChatRepository.getMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right([TestData.textChatCard]));
          return ChatBloc(mockChatRepository);
        },
        seed: () => ChatState(messages: [TestData.tokenSendCard]),
        act: (bloc) => bloc.add(ChatEvent.loadMessages(
          threadId: 'thread123',
          limit: 50,
          startAfter: DateTime(2024, 1, 1),
        )),
        expect: () => [
          isA<ChatState>().having(
              (s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ChatState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.messages.length, 'messages.length', 2)
              .having((s) => s.hasMoreMessages, 'hasMoreMessages', false),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'sets hasMoreMessages true when page is full',
        build: () {
          // Return exactly 50 items to trigger hasMoreMessages = true
          final fullPage = List.generate(
            50,
            (i) => TestData.textChatCard,
          );
          when(() => mockChatRepository.getMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => Right(fullPage));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.loadMessages(
          threadId: 'thread123',
          limit: 50,
        )),
        expect: () => [
          isA<ChatState>().having(
              (s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ChatState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.hasMoreMessages, 'hasMoreMessages', true),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when getMessages fails',
        build: () {
          when(() => mockChatRepository.getMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
                startAfter: any(named: 'startAfter'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.loadMessages(
          threadId: 'thread123',
        )),
        expect: () => [
          isA<ChatState>().having(
              (s) => s.isLoadingMessages, 'isLoadingMessages', true),
          isA<ChatState>()
              .having((s) => s.isLoadingMessages, 'isLoadingMessages', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('WatchMessages', () {
      blocTest<ChatBloc, ChatState>(
        'subscribes to messages stream and emits messagesUpdated',
        build: () {
          when(() => mockChatRepository.watchMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
              )).thenAnswer(
            (_) => Stream.value(Right(TestData.chatCardList)),
          );
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.watchMessages(
          threadId: 'thread123',
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.messages, 'messages', TestData.chatCardList),
        ],
        verify: (_) {
          verify(() => mockChatRepository.watchMessages(
                threadId: 'thread123',
                limit: null,
              )).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'cancels previous subscription when called again',
        build: () {
          when(() => mockChatRepository.watchMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
              )).thenAnswer(
            (_) => Stream.value(Right(TestData.chatCardList)),
          );
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) async {
          bloc.add(const ChatEvent.watchMessages(threadId: 'thread123'));
          await Future.delayed(const Duration(milliseconds: 50));
          bloc.add(const ChatEvent.watchMessages(threadId: 'thread456'));
        },
        wait: const Duration(milliseconds: 200),
        verify: (_) {
          verify(() => mockChatRepository.watchMessages(
                threadId: 'thread123',
                limit: null,
              )).called(1);
          verify(() => mockChatRepository.watchMessages(
                threadId: 'thread456',
                limit: null,
              )).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'does not emit on stream failure',
        build: () {
          when(() => mockChatRepository.watchMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
              )).thenAnswer(
            (_) => Stream.value(const Left(Failure.network())),
          );
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.watchMessages(
          threadId: 'thread123',
        )),
        wait: const Duration(milliseconds: 100),
        expect: () => [],
      );
    });

    group('MessagesUpdated', () {
      blocTest<ChatBloc, ChatState>(
        'updates messages in state',
        build: () => ChatBloc(mockChatRepository),
        act: (bloc) =>
            bloc.add(ChatEvent.messagesUpdated(TestData.chatCardList)),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.messages, 'messages', TestData.chatCardList),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'replaces existing messages',
        build: () => ChatBloc(mockChatRepository),
        seed: () => ChatState(messages: [TestData.textChatCard]),
        act: (bloc) =>
            bloc.add(ChatEvent.messagesUpdated(TestData.chatCardList)),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.messages.length, 'messages.length', 3),
        ],
      );
    });

    group('RequestTokens', () {
      blocTest<ChatBloc, ChatState>(
        'emits [sending, sent] when requestTokens succeeds',
        build: () {
          when(() => mockChatRepository.requestTokens(
                threadId: any(named: 'threadId'),
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
              )).thenAnswer((_) async => Right(TestData.tokenRequestCard));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.requestTokens(
          threadId: 'thread123',
          recipientId: 'user456',
          amount: 50,
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>().having((s) => s.isSending, 'isSending', false),
        ],
        verify: (_) {
          verify(() => mockChatRepository.requestTokens(
                threadId: 'thread123',
                recipientId: 'user456',
                amount: 50,
                message: null,
              )).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when requestTokens fails',
        build: () {
          when(() => mockChatRepository.requestTokens(
                threadId: any(named: 'threadId'),
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.requestTokens(
          threadId: 'thread123',
          recipientId: 'user456',
          amount: 50,
          message: 'Please send tokens',
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('AcceptTokenRequest', () {
      blocTest<ChatBloc, ChatState>(
        'calls repository and emits nothing on success',
        build: () {
          when(() => mockChatRepository.acceptTokenRequest(
                cardId: any(named: 'cardId'),
              )).thenAnswer((_) async => Right(TestData.tokenSendCard));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.acceptTokenRequest('card789')),
        expect: () => [],
        verify: (_) {
          verify(() => mockChatRepository.acceptTokenRequest(
                cardId: 'card789',
              )).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when acceptTokenRequest fails',
        build: () {
          when(() => mockChatRepository.acceptTokenRequest(
                cardId: any(named: 'cardId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.acceptTokenRequest('card789')),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('DeclineTokenRequest', () {
      blocTest<ChatBloc, ChatState>(
        'calls repository and emits nothing on success',
        build: () {
          when(() => mockChatRepository.declineTokenRequest(
                cardId: any(named: 'cardId'),
              )).thenAnswer((_) async => Right(TestData.tokenRequestCard));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.declineTokenRequest('card789')),
        expect: () => [],
        verify: (_) {
          verify(() => mockChatRepository.declineTokenRequest(
                cardId: 'card789',
              )).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when declineTokenRequest fails',
        build: () {
          when(() => mockChatRepository.declineTokenRequest(
                cardId: any(named: 'cardId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.declineTokenRequest('card789')),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('MarkAsRead', () {
      blocTest<ChatBloc, ChatState>(
        'calls repository markAsRead and emits nothing',
        build: () {
          when(() => mockChatRepository.markAsRead(
                threadId: any(named: 'threadId'),
                messageIds: any(named: 'messageIds'),
              )).thenAnswer((_) async => const Right(null));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.markAsRead(
          threadId: 'thread123',
          messageIds: ['card123', 'card456'],
        )),
        expect: () => [],
        verify: (_) {
          verify(() => mockChatRepository.markAsRead(
                threadId: 'thread123',
                messageIds: ['card123', 'card456'],
              )).called(1);
        },
      );
    });

    group('ToggleMuteThread', () {
      blocTest<ChatBloc, ChatState>(
        'mutes thread successfully with no state emission',
        build: () {
          when(() => mockChatRepository.toggleMuteThread(
                threadId: any(named: 'threadId'),
                isMuted: any(named: 'isMuted'),
              )).thenAnswer((_) async => const Right(null));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.toggleMuteThread(
          threadId: 'thread123',
          isMuted: true,
        )),
        expect: () => [],
        verify: (_) {
          verify(() => mockChatRepository.toggleMuteThread(
                threadId: 'thread123',
                isMuted: true,
              )).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when toggleMuteThread fails',
        build: () {
          when(() => mockChatRepository.toggleMuteThread(
                threadId: any(named: 'threadId'),
                isMuted: any(named: 'isMuted'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.toggleMuteThread(
          threadId: 'thread123',
          isMuted: true,
        )),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('ArchiveThread', () {
      blocTest<ChatBloc, ChatState>(
        'archives thread successfully with no state emission',
        build: () {
          when(() => mockChatRepository.archiveThread(any()))
              .thenAnswer((_) async => const Right(null));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.archiveThread('thread123')),
        expect: () => [],
        verify: (_) {
          verify(() => mockChatRepository.archiveThread('thread123'))
              .called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when archiveThread fails',
        build: () {
          when(() => mockChatRepository.archiveThread(any()))
              .thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.archiveThread('thread123')),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('GetOrCreateThread', () {
      blocTest<ChatBloc, ChatState>(
        'emits [loading, success] with selectedThread and starts watching messages',
        build: () {
          when(() => mockChatRepository.getOrCreateThread(
                participantId: any(named: 'participantId'),
              )).thenAnswer((_) async => Right(TestData.testChatThread));
          when(() => mockChatRepository.watchMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) => const Stream.empty());
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.getOrCreateThread('user456')),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.loading),
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.success)
              .having((s) => s.selectedThread?.id, 'selectedThread.id',
                  'thread123'),
        ],
        verify: (_) {
          verify(() => mockChatRepository.getOrCreateThread(
                participantId: 'user456',
              )).called(1);
          verify(() => mockChatRepository.watchMessages(
                threadId: 'thread123',
                limit: null,
              )).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'emits [loading, failure] when getOrCreateThread fails',
        build: () {
          when(() => mockChatRepository.getOrCreateThread(
                participantId: any(named: 'participantId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) =>
            bloc.add(const ChatEvent.getOrCreateThread('user456')),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.loading),
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('close', () {
      test('cancels all subscriptions on close', () async {
        when(() => mockChatRepository.watchChatThreads()).thenAnswer(
          (_) => Stream.value(Right(TestData.chatThreadList)),
        );
        when(() => mockChatRepository.watchTotalUnreadCount()).thenAnswer(
          (_) => Stream.value(const Right(0)),
        );
        when(() => mockChatRepository.watchMessages(
              threadId: any(named: 'threadId'),
              limit: any(named: 'limit'),
            )).thenAnswer(
          (_) => Stream.value(Right(TestData.chatCardList)),
        );

        final bloc = ChatBloc(mockChatRepository);
        bloc.add(const ChatEvent.watchThreads());
        bloc.add(const ChatEvent.watchMessages(threadId: 'thread123'));
        await Future.delayed(const Duration(milliseconds: 100));

        // Should not throw when closing with active subscriptions
        await bloc.close();
      });
    });
  });
}
